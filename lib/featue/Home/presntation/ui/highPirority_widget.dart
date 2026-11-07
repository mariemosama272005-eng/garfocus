
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:focus_flow/featue/Home/presntation/ui/highPiroTaskItem_widget.dart';
import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';
import 'package:focus_flow/featue/Home/presntation/ui/wedgit/emptypiroCard_widget.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

class HighPriorityTasksWidget extends StatelessWidget {
  const HighPriorityTasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubitCubit, TaskCubitState>(
      builder: (context, state) {
        if (state is! TaskCubitLoaded) {
          return const SizedBox.shrink();
        }

        final highTasks = state.tasks.where((task) {
          return task.priority == TaskPriority.high && !task.isCompleted;
        }).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'High Priority Tasks',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
            ),
            13.verticalSpace,
            if (highTasks.isEmpty)
              const EmptyPriorityCard()
            else
              ...highTasks.map(
                (task) => Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: HighPriorityTaskItem(task: task),
                ),
              ),
          ],
        );
      },
    );
  }
}