import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';

import 'package:focus_flow/featue/tasks/data/models/task_model.dart' hide TaskModel;
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

  String getDeadlineText(BuildContext context) {
    if (task.deadlineDate == null) {
      return '';
    }

    final String date =
        '${task.deadlineDate!.day}/'
        '${task.deadlineDate!.month}/'
        '${task.deadlineDate!.year}';

    if (task.deadlineMinutes == null) {
      return date;
    }

    final int minutes = task.deadlineMinutes!;

    final TimeOfDay time = TimeOfDay(
      hour: minutes ~/ 60,
      minute: minutes % 60,
    );

    final String formattedTime = time.format(context);

    return '$date • $formattedTime';
  }

  @override
  Widget build(BuildContext context) {
    final Color priorityColor = getPriorityColor();

    final bool isCompleted =
        task.status == 'completed';

    return Container(
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Priority color
          Container(
            width: 5.w,
            height: 120.h,
            decoration: BoxDecoration(
              color: priorityColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),

          12.horizontalSpace,

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  task.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                ),

                // Details
                if (task.details.isNotEmpty) ...[
                  5.verticalSpace,

                  Text(
                    task.details,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                  ),
                ],

                10.verticalSpace,

                // Category + Priority
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 5.h,
                      ),
                      decoration: BoxDecoration(
                        color:
                            priorityColor.withValues(alpha: 0.12),
                        borderRadius:
                            BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        task.category,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: priorityColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    8.horizontalSpace,

                    Text(
                      task.priority,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: priorityColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // Deadline
                if (getDeadlineText(context).isNotEmpty) ...[
                  8.verticalSpace,

                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 15.sp,
                        color: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.color,
                      ),

                      5.horizontalSpace,

                      Expanded(
                        child: Text(
                          getDeadlineText(context),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall,
                        ),
                      ),
                    ],
                  ),
                ],

                12.verticalSpace,

                // Complete button
                SizedBox(
                  height: 34.h,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final bool wasCompleted =
                          task.status == 'completed';

                      await context
                          .read<TaskCubitCubit>()
                          .completeTask(task as TaskModel);

                      if (!wasCompleted &&
                          context.mounted) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(
                          const SnackBar(
                            content: Text(
                              '🎉 Great job! You completed a task!',
                            ),
                            duration:
                                Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      isCompleted
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      size: 17.sp,
                    ),
                    label: Text(
                      isCompleted
                          ? 'Completed'
                          : 'Complete',
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