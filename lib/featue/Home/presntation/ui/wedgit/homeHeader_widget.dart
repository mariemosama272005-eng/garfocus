import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/featue/Home/presntation/cubit/cubit/gamification_cubit.dart';
import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.r),
          decoration: BoxDecoration(
            color: HomeScreen.primaryColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: const Icon(
            Icons.spa_rounded,
            color: HomeScreen.primaryColor,
            size: 26,
          ),
        ),
        10.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'FocusFlow',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: theme.textTheme.titleLarge?.color,
                ),
              ),
              Text(
                'One step at a time ✨',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: theme.textTheme.bodySmall?.color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        // Quick Focus launcher button
        InkWell(
          borderRadius: BorderRadius.circular(14.r),
          onTap: () async {
            final result = await Navigator.pushNamed(
              context,
              AppRoutes.focusScreen,
              arguments: {
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
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: HomeScreen.primaryColor,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: HomeScreen.primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer_outlined, color: Colors.white, size: 16),
                6.horizontalSpace,
                Text(
                  'Focus',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
