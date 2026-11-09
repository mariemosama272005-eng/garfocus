import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/FocusSession/data/models/focus_model.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';

class FocusDialogs {
  /// Smart Break Recommendation Dialog (Automatic break based on focus time)
  static void showBreakRecommendationDialog(
    BuildContext context, {
    required int studyMinutes,
    required int recommendedBreakMinutes,
    required VoidCallback onStartBreak,
    required VoidCallback onContinueStudying,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        elevation: 10,
        backgroundColor: theme.cardColor,
        child: Padding(
          padding: EdgeInsets.all(22.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon Badge in primary color (matching Focus theme)
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('☕', style: TextStyle(fontSize: 30.sp)),
                ),
              ),
              16.verticalSpace,

              // Title
              Text(
                'Time for a Break!',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
                textAlign: TextAlign.center,
              ),
              8.verticalSpace,

              // Description
              Text(
                studyMinutes > 0
                    ? "You've been studying hard for $studyMinutes minutes! Taking an automatic $recommendedBreakMinutes-minute break will help you recharge."
                    : "Your focus interval is complete! Time to take an automatic $recommendedBreakMinutes-minute break.",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: theme.textTheme.bodySmall?.color,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              16.verticalSpace,

              // Automatic Recommendation Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    color: primaryColor.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: primaryColor, size: 20.sp),
                    10.horizontalSpace,
                    Expanded(
                      child: Text(
                        'Automatic Break: $recommendedBreakMinutes Minutes',
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              22.verticalSpace,

              // Start Break Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    onStartBreak();
                  },
                  icon: const Icon(Icons.coffee, size: 20),
                  label: Text(
                    'Start Break ($recommendedBreakMinutes min)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
              10.verticalSpace,

              // Continue Studying Button
              SizedBox(
                width: double.infinity,
                height: 44.h,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.textTheme.bodyLarge?.color,
                    side: BorderSide(color: theme.dividerColor),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    onContinueStudying();
                  },
                  child: Text(
                    'Continue Studying',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Break Over Dialog
  static void showBreakOverDialog(
    BuildContext context, {
    required VoidCallback onResumeFocus,
    required VoidCallback onCompleteSession,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        elevation: 10,
        backgroundColor: theme.cardColor,
        child: Padding(
          padding: EdgeInsets.all(22.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('💪', style: TextStyle(fontSize: 30.sp)),
                ),
              ),
              16.verticalSpace,

              Text(
                'Break Over!',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              8.verticalSpace,

              Text(
                'Your break time is finished. Recharged and ready to dive back into deep focus?',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: theme.textTheme.bodySmall?.color,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              22.verticalSpace,

              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    onResumeFocus();
                  },
                  icon: const Icon(Icons.play_arrow, size: 20),
                  label: Text(
                    'Resume Focus',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
              10.verticalSpace,

              SizedBox(
                width: double.infinity,
                height: 44.h,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    onCompleteSession();
                  },
                  child: Text(
                    'Finish Session',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Clean Focus Session Summary Dialog
  static void showSessionSummaryDialog(
    BuildContext context, {
    required FocusStateModel state,
    required VoidCallback onDismiss,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final task = state.task;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
        elevation: 10,
        backgroundColor: theme.cardColor,
        child: Padding(
          padding: EdgeInsets.all(22.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Celebration Badge
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('🏆', style: TextStyle(fontSize: 32.sp)),
                ),
              ),
              14.verticalSpace,

              Text(
                'Session Completed!',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              4.verticalSpace,

              // Status badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.check_circle, color: Colors.green, size: 14.sp),
                    5.horizontalSpace,
                    Text(
                      task != null ? 'Task Marked Completed' : 'Session Completed',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              16.verticalSpace,

              // Task Name Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: theme.dividerColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TASK',
                      style: TextStyle(
                        color: theme.textTheme.bodySmall?.color,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      task?.title ?? 'General Focus Session',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                        color: theme.textTheme.bodyLarge?.color,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (task != null && task.category.isNotEmpty) ...[
                      4.verticalSpace,
                      Text(
                        task.category,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              14.verticalSpace,

              // Stats Grid (Study Time & Breaks Taken & XP)
              Row(
                children: [
                  Expanded(
                    child: _buildStatItem(
                      context,
                      icon: Icons.timer_outlined,
                      label: 'Focus Time',
                      value: state.focusedStudySeconds > 0
                          ? state.focusedTimeString
                          : '0m',
                      color: primaryColor,
                    ),
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: _buildStatItem(
                      context,
                      icon: Icons.coffee_outlined,
                      label: 'Breaks',
                      value: '${state.breaksTakenCount}',
                      color: primaryColor,
                    ),
                  ),
                  if (task != null) ...[
                    10.horizontalSpace,
                    Expanded(
                      child: _buildStatItem(
                        context,
                        icon: Icons.bolt,
                        label: 'Reward',
                        value: '+10 XP',
                        color: primaryColor,
                      ),
                    ),
                  ],
                ],
              ),
              16.verticalSpace,

              // Motivational Message
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('“',
                        style: TextStyle(
                            fontSize: 24.sp,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            height: 1.0)),
                    8.horizontalSpace,
                    Expanded(
                      child: Text(
                        state.motivationalMessage ??
                            'Consistency is key to unlocking your highest potential.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: theme.textTheme.bodyLarge?.color,
                          fontStyle: FontStyle.italic,
                          height: 1.35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpace,

              // Done / Back to Tasks Button
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    onDismiss();
                  },
                  icon: const Icon(Icons.arrow_back, size: 18),
                  label: Text(
                    'Back to Tasks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.sp),
          6.verticalSpace,
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: theme.textTheme.bodyLarge?.color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          2.verticalSpace,
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: theme.textTheme.bodySmall?.color,
            ),
          ),
        ],
      ),
    );
  }

  /// Confirmation dialog when navigating away from active session
  static Future<bool> showExitConfirmDialog(
    BuildContext context, {
    required String studyTime,
  }) async {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        backgroundColor: theme.cardColor,
        title: const Text('Leave Focus Session?'),
        content: Text(
          'You have an active session in progress ($studyTime focused). Leaving will end this session.',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(
              'Keep Focusing',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text(
              'Leave',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    return result ?? false;
  }
}
