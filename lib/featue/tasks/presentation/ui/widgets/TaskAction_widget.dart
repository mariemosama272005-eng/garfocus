
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

class TaskActionButton extends StatelessWidget {
  final TaskModel task;
  final bool isCompleted;

  const TaskActionButton({
    super.key,
    required this.task,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 38.h,
      child: OutlinedButton.icon(
        onPressed: () async {
          final success =
              await context.read<TaskCubitCubit>().completeTask(task);

          if (!context.mounted) return;

          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
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
          isCompleted ? Icons.check_circle : Icons.circle_outlined,
          size: 17.sp,
        ),
        label: Text(
          isCompleted ? 'Completed' : 'Complete',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}