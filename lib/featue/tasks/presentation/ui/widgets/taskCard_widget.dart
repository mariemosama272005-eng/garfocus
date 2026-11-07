import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/addTask_screen.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';
import 'package:focus_flow/featue/tasks/presentation/ui/widgets/TaskAction_widget.dart';
import 'package:focus_flow/featue/tasks/presentation/ui/widgets/taskCatPiro_widget.dart';
import 'package:focus_flow/featue/tasks/presentation/ui/widgets/taskDeadline_widget.dart';
import 'package:focus_flow/featue/tasks/presentation/ui/widgets/taskDitails_widget.dart';
import 'package:focus_flow/featue/tasks/presentation/ui/widgets/taskHeader_widget.dart';
import 'package:focus_flow/featue/tasks/presentation/ui/widgets/taskPirority_widget.dart';

class TaskCardWidget extends StatelessWidget {
  final TaskModel task;

  const TaskCardWidget({
    super.key,
    required this.task,
  });

  Color _getPriorityColor() {
    switch (task.priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.blue;
      case TaskPriority.low:
        return Colors.green;
    }
  }

  String _getPriorityName() {
    switch (task.priority) {
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }

  @override
  Widget build(BuildContext context) {
    final priorityColor = _getPriorityColor();
    final isCompleted = task.isCompleted;

  return InkWell(
  borderRadius: BorderRadius.circular(14.r),
  onTap: () async {
    final result = await Navigator.pushNamed(
      context,
      AppRoutes.focusScreen,
      arguments: {
        'task': task,
        'taskCubit': context.read<TaskCubitCubit>(),
      },
    );
    if (result == true && context.mounted) {
      context.read<TaskCubitCubit>().getTasks();
    }
  },
  child: Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.w),
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
        TaskPriorityBar(color: priorityColor),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskHeaderWidget(
                task: task,
                isCompleted: isCompleted,
                priorityColor: priorityColor,
              ),

              if (task.details.isNotEmpty) ...[
                5.verticalSpace,
                TaskDetailsWidget(
                  details: task.details,
                  isCompleted: isCompleted,
                ),
              ],
              10.verticalSpace,
              TaskCategoryAndPriority(
                task: task,
                priorityColor: priorityColor,
                priorityName: _getPriorityName(),
              ),
              TaskDeadlineWidget(task: task),
              12.verticalSpace,
              TaskActionButton(
                task: task,
                isCompleted: isCompleted,
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
  }
  }