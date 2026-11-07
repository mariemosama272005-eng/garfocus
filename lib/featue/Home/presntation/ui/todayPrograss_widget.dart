


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

class TodayProgressWidget extends StatelessWidget {
  const TodayProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubitCubit, TaskCubitState>(
      builder: (context, state) {
        if (state is! TaskCubitLoaded) {
          return const SizedBox.shrink();
        }

        final tasks = state.tasks;
        final now = DateTime.now();

        final todayTasks = tasks.where((task) {
          final date = task.deadlineDate;
          if (date == null) return false;
          return date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;
        }).toList();

        final completed = todayTasks.where((task) => task.isCompleted).length;
        final total = todayTasks.length;
        final progress = total == 0 ? 0.0 : completed / total;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(17.r),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Theme.of(context).dividerColor),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.track_changes, color: HomeScreen.primaryColor),
                  8.horizontalSpace,
                  Expanded(
                    child: Text(
                      "Today's Progress",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.titleMedium?.color,
                      ),
                    ),
                  ),
                  Text(
                    '$completed / $total',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
              14.verticalSpace,
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  minHeight: 11.h,
                  backgroundColor: Theme.of(context).dividerColor,
                  valueColor: const AlwaysStoppedAnimation(
                    HomeScreen.primaryColor,
                  ),
                ),
              ),
              8.verticalSpace,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${(progress * 100).round()}%',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
