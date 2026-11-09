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
    final isSelected = currentValue == minutes;

    return GestureDetector(
      onTap: () => onTap(minutes),
      child: Container(
        width: 65.w,
        height: 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? Colors.purple : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          '$minutes',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
