import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:focus_flow/featue/addTasks/presntation/ui/addTask_screen.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel task;

  const TaskCardWidget({
    super.key,
    required this.task,
  });

  Color getPriorityColor() {
    switch (task.priority) {
      case 'High':
        return Colors.red;

      case 'Medium':
        return Colors.blue;

      case 'Low':
        return Colors.green;

      default:
        return Colors.blue;
    }
  }

  String getDeadlineText(
    BuildContext context,
  ) {
    if (task.deadlineDate == null) {
      return '';
    }

    final date =
        '${task.deadlineDate!.day}/'
        '${task.deadlineDate!.month}/'
        '${task.deadlineDate!.year}';

    if (task.deadlineMinutes == null) {
      return date;
    }

    final minutes = task.deadlineMinutes!;

    final time = TimeOfDay(
      hour: minutes ~/ 60,
      minute: minutes % 60,
    );

    return '$date • ${time.format(context)}';
  }

  void editTask(
    BuildContext context,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            AddTaskScreen(task: task),
      ),
    );
  }

  Future<void> deleteTask(
    BuildContext context,
  ) async {
    final confirm =
        await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title:
              const Text('Delete Task?'),
          content: const Text(
            'Are you sure you want to delete this task?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child:
                  const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true ||
        !context.mounted) {
      return;
    }

    final success =
        await context
            .read<TaskCubitCubit>()
            .deleteTask(task);

    if (!context.mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(
          success
              ? 'Task deleted successfully'
              : 'Failed to delete task',
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final priorityColor =
        getPriorityColor();

    final isCompleted =
        task.status.trim().toLowerCase() ==
            'completed';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color:
            Theme.of(context).cardColor,
        borderRadius:
            BorderRadius.circular(14.r),
        border: Border.all(
          color:
              Theme.of(context)
                  .dividerColor,
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          // =========================
          // PRIORITY BAR
          // =========================

          Container(
            width: 5.w,
            constraints:
                BoxConstraints(
              minHeight: 50.h,
            ),
            decoration:
                BoxDecoration(
              color: priorityColor,
              borderRadius:
                  BorderRadius.circular(
                10.r,
              ),
            ),
          ),

          10.horizontalSpace,

          // =========================
          // CONTENT
          // =========================

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // =========================
                // TITLE + MENU
                // =========================

                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        task.title,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                        style: Theme.of(
                          context,
                        )
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                              fontWeight:
                                  FontWeight.bold,
                              decoration:
                                  isCompleted
                                      ? TextDecoration
                                          .lineThrough
                                      : null,
                            ),
                      ),
                    ),

                    SizedBox(
                      width: 40.w,
                      child:
                          PopupMenuButton<
                              String>(
                        padding:
                            EdgeInsets.zero,
                        onSelected:
                            (value) {
                          if (value ==
                              'edit') {
                            editTask(
                              context,
                            );
                          }

                          if (value ==
                              'delete') {
                            deleteTask(
                              context,
                            );
                          }
                        },
                        itemBuilder:
                            (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(
                                  Icons
                                      .edit_outlined,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Edit',
                                ),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(
                                  Icons
                                      .delete_outline,
                                  color:
                                      Colors.red,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Delete',
                                  style:
                                      TextStyle(
                                    color:
                                        Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // =========================
                // DETAILS
                // =========================

                if (task.details.isNotEmpty) ...[
                  5.verticalSpace,

                  Text(
                    task.details,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    )
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          decoration:
                              isCompleted
                                  ? TextDecoration
                                      .lineThrough
                                  : null,
                        ),
                  ),
                ],

                10.verticalSpace,

                // =========================
                // CATEGORY + PRIORITY
                // =========================

                Wrap(
                  spacing: 8.w,
                  runSpacing: 5.h,
                  children: [
                    Container(
                      constraints:
                          BoxConstraints(
                        maxWidth:
                            180.w,
                      ),
                      padding:
                          EdgeInsets
                              .symmetric(
                        horizontal: 9.w,
                        vertical: 5.h,
                      ),
                      decoration:
                          BoxDecoration(
                        color:
                            priorityColor
                                .withValues(
                          alpha: 0.12,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                          8.r,
                        ),
                      ),
                      child: Text(
                        task.category,
                        maxLines: 1,
                        overflow:
                            TextOverflow
                                .ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color:
                              priorityColor,
                          fontWeight:
                              FontWeight.w600,
                        ),
                      ),
                    ),

                    Text(
                      task.priority,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color:
                            priorityColor,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // =========================
                // DEADLINE
                // =========================

                if (getDeadlineText(
                  context,
                ).isNotEmpty) ...[
                  8.verticalSpace,

                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 15.sp,
                        color: Theme.of(
                          context,
                        )
                            .textTheme
                            .bodySmall
                            ?.color,
                      ),

                      5.horizontalSpace,

                      Expanded(
                        child: Text(
                          getDeadlineText(
                            context,
                          ),
                          maxLines: 1,
                          overflow:
                              TextOverflow
                                  .ellipsis,
                          style: Theme.of(
                            context,
                          )
                              .textTheme
                              .bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],

                12.verticalSpace,

                // =========================
                // COMPLETE BUTTON
                // =========================

                SizedBox(
                  width: double.infinity,
                  height: 38.h,
                  child:
                      OutlinedButton.icon(
                    onPressed: () async {
                      final success =
                          await context
                              .read<
                                  TaskCubitCubit>()
                              .completeTask(
                                task,
                              );

                      if (!context.mounted) {
                        return;
                      }

                      if (success) {
                        ScaffoldMessenger
                                .of(context)
                            .showSnackBar(
                          SnackBar(
                            content: Text(
                              isCompleted
                                  ? 'Task marked as pending'
                                  : '🎉 Great job! Task completed!',
                            ),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      isCompleted
                          ? Icons
                              .check_circle
                          : Icons
                              .circle_outlined,
                      size: 17.sp,
                    ),
                    label: Text(
                      isCompleted
                          ? 'Completed'
                          : 'Complete',
                      maxLines: 1,
                      overflow:
                          TextOverflow
                              .ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}