

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';

class TaskCategoryAndPriority extends StatelessWidget {
  final TaskModel task;
  final Color priorityColor;
  final String priorityName;

  const TaskCategoryAndPriority({
    super.key,
    required this.task,
    required this.priorityColor,
    required this.priorityName,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 5.h,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 180.w),
          padding: EdgeInsets.symmetric(
            horizontal: 9.w,
            vertical: 5.h,
          ),
          decoration: BoxDecoration(
            color: priorityColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            task.category,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11.sp,
              color: priorityColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          priorityName,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 11.sp,
            color: priorityColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
