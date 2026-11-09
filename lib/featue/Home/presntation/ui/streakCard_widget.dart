import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StreakCardWidget extends StatelessWidget {
  final int streak;
  final int bestStreak;
  final bool hasActivityToday;

  const StreakCardWidget({
    super.key,
    required this.streak,
    this.bestStreak = 0,
    this.hasActivityToday = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: streak > 0
              ? const Color(0xFFFFB300).withOpacity(0.4)
              : theme.dividerColor,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: streak > 0
                ? const Color(0xFFFFB300).withOpacity(0.08)
                : Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: streak > 0
                  ? const Color(0xFFFFE0B2)
                  : Colors.grey.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                streak > 0 ? '🔥' : '🌱',
                style: TextStyle(fontSize: 22.sp),
              ),
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$streak Day Streak',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                    ),
                    if (bestStreak > streak && bestStreak > 0) ...[
                      8.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.14),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          'Best: $bestStreak',
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.amberAccent : Colors.orange.shade800,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                4.verticalSpace,
                Text(
                  hasActivityToday
                      ? 'Streak preserved for today! ✨'
                      : (streak > 0
                          ? 'Complete 1 task or focus session to extend!'
                          : 'Start a session today to begin your streak!'),
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: theme.textTheme.bodySmall?.color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
