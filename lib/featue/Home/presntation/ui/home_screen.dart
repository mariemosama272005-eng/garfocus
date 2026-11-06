import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';
import 'package:focus_flow/featue/Home/presntation/cubit/cubit/gamification_cubit.dart';
import 'package:focus_flow/featue/Home/presntation/ui/wedgit/dolphineChar_widget.dart';

import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color primary = Color(0xFF7653D6);
  static const Color dark = Color(0xFF30205D);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _header(context),

          25.verticalSpace,

          BlocBuilder<GamificationCubit, GamificationModel>(
            builder: (context, data) {
              return Column(
                children: [
                  _welcome(data.level),

                  15.verticalSpace,

                  _levelCard(
                    context,
                    data.level,
                    data.currentLevelXp,
                    data.progress,
                    data.xp,
                  ),

                  15.verticalSpace,

                  _streakCard(
                    context,
                    data.streak,
                  ),
                ],
              );
            },
          ),

          22.verticalSpace,

          _todayProgress(context),

          22.verticalSpace,

          _highPriorityTasks(context),
        ],
      ),
    );
  }

  // ================= HEADER =================

  Widget _header(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.spa_rounded,
          color: primary,
          size: 32,
        ),

        8.horizontalSpace,

        Expanded(
          child: Text(
            'FocusFlow',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 23.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.color,
            ),
          ),
        ),

        Icon(
          Icons.notifications_none_rounded,
          color: Theme.of(context).iconTheme.color,
        ),
      ],
    );
  }

  // ================= DOLPHIN =================

  Widget _welcome(int level) {
    return DolphinCharacterWidget(
      level: level,
    );
  }

  // ================= LEVEL CARD =================

  Widget _levelCard(
    BuildContext context,
    int level,
    int currentXp,
    double progress,
    int totalXp,
  ) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.r),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF352B50)
            : const Color(0xFFEAE2FF),
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        children: [
          // LEVEL BOX (Fixed width overflow resolved)
          Container(
            constraints: BoxConstraints(minWidth: 75.w),
            height: 70.h,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD77B),
              borderRadius: BorderRadius.circular(17.r),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'LEVEL',
                  style: TextStyle(
                    color: dark,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  '$level',
                  style: TextStyle(
                    fontSize: 27.sp,
                    fontWeight: FontWeight.bold,
                    color: dark,
                  ),
                ),
              ],
            ),
          ),

          13.horizontalSpace,

          // XP
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  '$currentXp / 100 XP',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    color: isDark
                        ? Colors.white
                        : dark,
                  ),
                ),

                10.verticalSpace,

                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20.r),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 10.h,
                    backgroundColor:
                        isDark
                            ? Colors.white24
                            : Colors.white,
                    valueColor:
                        const AlwaysStoppedAnimation(
                      primary,
                    ),
                  ),
                ),

                5.verticalSpace,

                Text(
                  '$totalXp Total XP',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: isDark
                        ? Colors.white70
                        : dark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= STREAK =================

  Widget _streakCard(
    BuildContext context,
    int streak,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        children: [
          const Text(
            '🔥',
            style: TextStyle(fontSize: 26),
          ),

          10.horizontalSpace,

          Expanded(
            child: Text(
              '$streak Day Streak',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= TODAY PROGRESS =================

  Widget _todayProgress(BuildContext context) {
    return BlocBuilder<TaskCubitCubit, TaskCubitState>(
      builder: (context, state) {
        if (state is! TaskCubitLoaded) {
          return const SizedBox.shrink();
        }

        final tasks = state.tasks;

        final now = DateTime.now();

        final todayTasks = tasks.where((task) {
          final date = task.deadlineDate;

          if (date == null) {
            return false;
          }

          return date.year == now.year &&
              date.month == now.month &&
              date.day == now.day;
        }).toList();

        final completed =
            todayTasks.where((task) {
          return task.status
                  .toLowerCase() ==
              'completed';
        }).length;

        final total = todayTasks.length;

        final progress = total == 0
            ? 0.0
            : completed / total;

        return _progressCard(
          context,
          completed,
          total,
          progress,
        );
      },
    );
  }

  // ================= PROGRESS CARD =================

  Widget _progressCard(
    BuildContext context,
    int completed,
    int total,
    double progress,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Theme.of(context).dividerColor,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.track_changes,
                color: primary,
              ),

              8.horizontalSpace,

              Expanded(
                child: Text(
                  "Today's Progress",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.color,
                  ),
                ),
              ),

              Text(
                '$completed / $total',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.color,
                ),
              ),
            ],
          ),

          14.verticalSpace,

          ClipRRect(
            borderRadius:
                BorderRadius.circular(20.r),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 11.h,
              backgroundColor:
                  Theme.of(context).dividerColor,
              valueColor:
                  const AlwaysStoppedAnimation(
                primary,
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
                color: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= HIGH PRIORITY =================

  Widget _highPriorityTasks(
    BuildContext context,
  ) {
    return BlocBuilder<TaskCubitCubit, TaskCubitState>(
      builder: (context, state) {
        if (state is! TaskCubitLoaded) {
          return const SizedBox.shrink();
        }

        final highTasks =
            state.tasks.where((task) {
          return task.priority == 'High' &&
              task.status.toLowerCase() !=
                  'completed';
        }).toList();

        return Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'High Priority Tasks',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.color,
              ),
            ),

            13.verticalSpace,

            if (highTasks.isEmpty)
              _emptyPriorityCard(context)
            else
              ...highTasks.map(
                (task) => Padding(
                  padding:
                      EdgeInsets.only(bottom: 10.h),
                  child: _taskItem(
                    context,
                    task,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  // ================= EMPTY HIGH PRIORITY =================

  Widget _emptyPriorityCard(
    BuildContext context,
  ) {
    final isDark =
        Theme.of(context).brightness ==
            Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF203C32)
            : const Color(0xFFEAF8F2),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Text(
        '🎉 No high priority tasks! You are all caught up.',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: isDark
              ? const Color(0xFF9AE0BE)
              : const Color(0xFF287A57),
        ),
      ),
    );
  }

  // ================= TASK ITEM =================

  Widget _taskItem(
    BuildContext context,
    TaskModel task,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius:
            BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFFFD6D6),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight:
                        FontWeight.bold,
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.color,
                  ),
                ),

                5.verticalSpace,

                Text(
                  task.category,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color,
                  ),
                ),
              ],
            ),
          ),

          10.horizontalSpace,

          Container(
            padding:
                EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              color: const Color(
                0xFFFFE2E2,
              ),
              borderRadius:
                  BorderRadius.circular(10.r),
            ),
            child: Text(
              'High',
              maxLines: 1,
              style: TextStyle(
                color: Colors.red,
                fontSize: 12.sp,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}