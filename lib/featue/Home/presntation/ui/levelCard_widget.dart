
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';

class LevelCardWidget extends StatelessWidget {
  final int level;
  final int currentXp;
  final double progress;
  final int totalXp;

  const LevelCardWidget({
    super.key,
    required this.level,
    required this.currentXp,
    required this.progress,
    required this.totalXp,
  });

  static const Color darkColor = Color(0xFF30205D);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.r),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF352B50) : const Color(0xFFEAE2FF),
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        children: [
  
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
                    color: darkColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$level',
                  style: TextStyle(
                    fontSize: 27.sp,
                    fontWeight: FontWeight.bold,
                    color: darkColor,
                  ),
                ),
              ],
            ),
          ),
          13.horizontalSpace,
     
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$currentXp / 100 XP',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.sp,
                    color: isDark ? Colors.white : darkColor,
                  ),
                ),
                10.verticalSpace,
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: LinearProgressIndicator(
                    value: progress.clamp(0.0, 1.0),
                    minHeight: 10.h,
                    backgroundColor: isDark ? Colors.white24 : Colors.white,
                    valueColor: const AlwaysStoppedAnimation(
                      HomeScreen.primaryColor,
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
                    color: isDark ? Colors.white70 : darkColor,
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
