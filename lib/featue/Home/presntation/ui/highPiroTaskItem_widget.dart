import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/featue/Home/presntation/cubit/cubit/gamification_cubit.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

class HighPriorityTaskItem extends StatelessWidget {
  final TaskModel task;

  const HighPriorityTaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16.r),
      onTap: () async {
        final result = await Navigator.pushNamed(
          context,
          AppRoutes.focusScreen,
          arguments: {
            'task': task,
            'taskCubit': context.read<TaskCubitCubit>(),
            'gamificationCubit': context.read<GamificationCubit>(),
          },
        );
        if (result == true && context.mounted) {
          context.read<TaskCubitCubit>().getTasks();
          context.read<GamificationCubit>().loadData();
        }
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(15.r),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFFFFD6D6),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  5.verticalSpace,
                  Text(
                    task.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
            10.horizontalSpace,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 6.h,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE2E2),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'High',
                maxLines: 1,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
