
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressStepsIndicator extends StatelessWidget {
  final int activeStepIndex;

  const ProgressStepsIndicator({super.key, required this.activeStepIndex});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          final isActive = index == activeStepIndex;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: isActive ? 20.w : 8.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: isActive ? Colors.purple : Colors.purple.shade100,
              borderRadius: BorderRadius.circular(4.r),
            ),
          );
        }),
      ),
    );
  }
}
