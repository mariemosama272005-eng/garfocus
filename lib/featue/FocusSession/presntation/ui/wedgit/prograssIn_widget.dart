import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressStepsIndicator extends StatelessWidget {
  final int activeStepIndex;

  const ProgressStepsIndicator({
    super.key,
    required this.activeStepIndex,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          final isActive = index == activeStepIndex;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(horizontal: 4.w),
            width: isActive ? 24.w : 8.w,
            height: 6.h,
            decoration: BoxDecoration(
              color: isActive ? primaryColor : primaryColor.withOpacity(0.18),
              borderRadius: BorderRadius.circular(4.r),
            ),
          );
        }),
      ),
    );
  }
}
