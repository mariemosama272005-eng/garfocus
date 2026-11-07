import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeChipWidget extends StatelessWidget {
  final int minutes;
  final int currentValue;
  final Function(int?) onTap;

  const TimeChipWidget({
    super.key,
    required this.minutes,
    required this.currentValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final isSelected = currentValue == minutes;

    return GestureDetector(
      onTap: () => onTap(minutes),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 66.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : theme.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? primaryColor : theme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$minutes',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                height: 1.2,
                color: isSelected
                    ? Colors.white
                    : theme.textTheme.bodyLarge?.color,
              ),
            ),
            Text(
              'min',
              style: TextStyle(
                fontSize: 10.sp,
                height: 1.2,
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.9)
                    : theme.textTheme.bodySmall?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
