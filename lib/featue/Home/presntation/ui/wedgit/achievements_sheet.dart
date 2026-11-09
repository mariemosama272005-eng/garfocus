import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/Home/data/models/achievement_model.dart';
import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';

class AchievementsSheet extends StatelessWidget {
  final GamificationModel gamification;

  const AchievementsSheet({super.key, required this.gamification});

  static void show(BuildContext context, GamificationModel gamification) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AchievementsSheet(gamification: gamification),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    final all = Achievement.allAchievements;
    final unlockedCount = all
        .where((a) => gamification.isAchievementUnlocked(a.id))
        .length;

    return Container(
      constraints: BoxConstraints(maxHeight: 0.82.sh),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1A29) : Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 44.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: theme.dividerColor,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          16.verticalSpace,

          // Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD77B).withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: const Text('🏅', style: TextStyle(fontSize: 22)),
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Achievements',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.titleLarge?.color,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      '$unlockedCount of ${all.length} Badges Unlocked',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: theme.textTheme.bodySmall?.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),

          16.verticalSpace,

          // List of achievements
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: all.length,
              separatorBuilder: (_, __) => 10.verticalSpace,
              itemBuilder: (context, index) {
                final achievement = all[index];
                final isUnlocked =
                    gamification.isAchievementUnlocked(achievement.id);

                return Container(
                  padding: EdgeInsets.all(14.r),
                  decoration: BoxDecoration(
                    color: isUnlocked
                        ? (isDark
                            ? const Color(0xFF2C2344)
                            : const Color(0xFFF7F3FF))
                        : (isDark
                            ? const Color(0xFF171320)
                            : const Color(0xFFF6F6F8)),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: isUnlocked
                          ? primaryColor.withOpacity(0.4)
                          : theme.dividerColor.withOpacity(0.4),
                      width: isUnlocked ? 1.4 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 48.r,
                        height: 48.r,
                        decoration: BoxDecoration(
                          color: isUnlocked
                              ? const Color(0xFFFFD77B).withOpacity(0.3)
                              : Colors.grey.withOpacity(0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            achievement.icon,
                            style: TextStyle(
                              fontSize: 24.sp,
                              color: isUnlocked ? null : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      14.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  achievement.title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                    color: isUnlocked
                                        ? theme.textTheme.titleMedium?.color
                                        : theme.textTheme.bodySmall?.color,
                                  ),
                                ),
                                8.horizontalSpace,
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primaryColor.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    achievement.category,
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w600,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            4.verticalSpace,
                            Text(
                              achievement.description,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.horizontalSpace,
                      Icon(
                        isUnlocked
                            ? Icons.check_circle_rounded
                            : Icons.lock_outline_rounded,
                        color: isUnlocked
                            ? Colors.green
                            : Colors.grey.withOpacity(0.6),
                        size: 22.sp,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
