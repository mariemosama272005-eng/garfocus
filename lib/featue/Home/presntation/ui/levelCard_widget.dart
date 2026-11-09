import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';

class LevelCardWidget extends StatelessWidget {
  final int level;
  final int currentXp;
  final double progress;
  final int totalXp;
  final int dailyXp;
  final String levelTitle;

  const LevelCardWidget({
    super.key,
    required this.level,
    required this.currentXp,
    required this.progress,
    required this.totalXp,
    this.dailyXp = 0,
    this.levelTitle = 'Focus Starter',
  });

  static const Color darkColor = Color(0xFF30205D);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final xpToNext = (100 - currentXp).clamp(0, 100);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2B2244) : const Color(0xFFEFE9FC),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: isDark ? const Color(0xFF45366B) : const Color(0xFFD6C8F5),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Level Badge
              Container(
                constraints: BoxConstraints(minWidth: 68.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFDF88), Color(0xFFFFC745)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFFC745).withOpacity(0.35),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'LEVEL',
                      style: TextStyle(
                        color: darkColor,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Text(
                      '$level',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: darkColor,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),

              14.horizontalSpace,

              // Level title & XP counters
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            levelTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : darkColor,
                            ),
                          ),
                        ),
                        if (dailyXp > 0)
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 3.h,
                            ),
                            decoration: BoxDecoration(
                              color: HomeScreen.primaryColor.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              '+$dailyXp XP today',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? const Color(0xFFC7B1FA)
                                    : HomeScreen.primaryColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                    6.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$currentXp / 100 XP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                            color: isDark ? Colors.white70 : darkColor,
                          ),
                        ),
                        Text(
                          '$xpToNext XP to Lvl ${level + 1}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white54 : Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          12.verticalSpace,

          // Progress Bar with percentage
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 10.h,
              backgroundColor: isDark ? Colors.white12 : Colors.white,
              valueColor: const AlwaysStoppedAnimation(
                HomeScreen.primaryColor,
              ),
            ),
          ),

          6.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total XP: $totalXp',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white60 : Colors.grey.shade700,
                ),
              ),
              Text(
                '${(progress * 100).toInt()}% Complete',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFC7B1FA) : HomeScreen.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
