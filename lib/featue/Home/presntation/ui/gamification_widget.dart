import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/Home/data/models/achievement_model.dart';
import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';
import 'package:focus_flow/featue/Home/presntation/cubit/cubit/gamification_cubit.dart';
import 'package:focus_flow/featue/Home/presntation/ui/levelCard_widget.dart';
import 'package:focus_flow/featue/Home/presntation/ui/streakCard_widget.dart';
import 'package:focus_flow/featue/Home/presntation/ui/wedgit/achievements_sheet.dart';
import 'package:focus_flow/featue/Home/presntation/ui/wedgit/study_buddy_widget.dart';

class GamificationSectionWidget extends StatelessWidget {
  const GamificationSectionWidget({super.key});

  String _todayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return BlocBuilder<GamificationCubit, GamificationModel>(
      builder: (context, data) {
        final allAchievements = Achievement.allAchievements;
        final unlockedCount = allAchievements
            .where((a) => data.isAchievementUnlocked(a.id))
            .length;

        final hasActivityToday = data.achievementDays.contains(_todayKey());

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Study Buddy with animated avatar & context-aware speech bubble
            const StudyBuddyWidget(),

            16.verticalSpace,

            // Level & XP Card
            LevelCardWidget(
              level: data.level,
              currentXp: data.currentLevelXp,
              progress: data.progress,
              totalXp: data.xp,
              dailyXp: data.dailyXp,
              levelTitle: data.levelTitle,
            ),

            12.verticalSpace,

            // Streak Card
            StreakCardWidget(
              streak: data.streak,
              bestStreak: data.bestStreak,
              hasActivityToday: hasActivityToday,
            ),

            14.verticalSpace,

            // Achievements / Badges Preview
            GestureDetector(
              onTap: () => AchievementsSheet.show(context, data),
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14.r),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('🏅', style: TextStyle(fontSize: 16)),
                        8.horizontalSpace,
                        Text(
                          'Badges & Milestones',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.titleMedium?.color,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '$unlockedCount/${allAchievements.length} Unlocked',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        4.horizontalSpace,
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 12.sp,
                          color: primaryColor,
                        ),
                      ],
                    ),

                    12.verticalSpace,

                    // Horizontal list of badges
                    SizedBox(
                      height: 72.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: allAchievements.length,
                        separatorBuilder: (_, __) => 10.horizontalSpace,
                        itemBuilder: (context, index) {
                          final achievement = allAchievements[index];
                          final isUnlocked =
                              data.isAchievementUnlocked(achievement.id);

                          return Container(
                            width: 68.w,
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: isUnlocked
                                  ? (isDark
                                      ? const Color(0xFF2C2245)
                                      : const Color(0xFFF3EDFF))
                                  : (isDark
                                      ? Colors.white.withOpacity(0.04)
                                      : const Color(0xFFF7F7F8)),
                              borderRadius: BorderRadius.circular(14.r),
                              border: Border.all(
                                color: isUnlocked
                                    ? primaryColor.withOpacity(0.4)
                                    : theme.dividerColor.withOpacity(0.6),
                                width: isUnlocked ? 1.4 : 1.0,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  achievement.icon,
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: isUnlocked
                                        ? null
                                        : Colors.grey.withOpacity(0.5),
                                  ),
                                ),
                                4.verticalSpace,
                                Text(
                                  achievement.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 9.sp,
                                    fontWeight: isUnlocked
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isUnlocked
                                        ? (isDark ? Colors.white : Colors.black87)
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
