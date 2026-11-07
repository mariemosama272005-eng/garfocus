import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskPriorityBar extends StatelessWidget {
  final Color color;

  const TaskPriorityBar({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 5.w,
      constraints: BoxConstraints(minHeight: 50.h),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }
}