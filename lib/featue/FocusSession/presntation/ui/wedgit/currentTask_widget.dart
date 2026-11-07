import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';

class CurrentTaskCardWidget extends StatelessWidget {
  final TaskModel? task;

  const CurrentTaskCardWidget({
    super.key,
    this.task,
  });

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.blue;
      case TaskPriority.low:
        return Colors.green;
    }
  }

  String _getPriorityLabel(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    if (task == null) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text('🎯', style: TextStyle(fontSize: 22.sp)),
              ),
            ),
            14.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'General Focus Session',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  3.verticalSpace,
                  Text(
                    'Deep work without a specific task',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final priorityColor = _getPriorityColor(task!.priority);
    final priorityLabel = _getPriorityLabel(task!.priority);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: theme.dividerColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Working on label
              Row(
                children: [
                  Text('✍️', style: TextStyle(fontSize: 16.sp)),
                  6.horizontalSpace,
                  Text(
                    'FOCUSING ON',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),

              // Priority Chip
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: priorityColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: priorityColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        color: priorityColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    5.horizontalSpace,
                    Text(
                      priorityLabel,
                      style: TextStyle(
                        color: priorityColor,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          10.verticalSpace,

          // Task Title
          Text(
            task!.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17.sp,
              color: theme.textTheme.bodyLarge?.color,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          if (task!.category.isNotEmpty || task!.deadlineMinutes != null) ...[
            10.verticalSpace,
            Row(
              children: [
                if (task!.category.isNotEmpty) ...[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      task!.category,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: theme.textTheme.bodySmall?.color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                ],
                if (task!.deadlineMinutes != null) ...[
                  Icon(
                    Icons.access_time,
                    size: 13.sp,
                    color: theme.textTheme.bodySmall?.color,
                  ),
                  4.horizontalSpace,
                  Text(
                    '${task!.deadlineMinutes}m deadline',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
