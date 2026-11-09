import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimerCircularIndicator extends StatelessWidget {
  final double progressValue;
  final String statusText;
  final String timerString;
  final String timerState;
  final int selectedBreakMinutes;
  final int selectedFocusMinutes;
  final String focusedTimeString;

  const TimerCircularIndicator({
    super.key,
    required this.progressValue,
    required this.statusText,
    required this.timerString,
    required this.timerState,
    required this.selectedBreakMinutes,
    required this.selectedFocusMinutes,
    required this.focusedTimeString,
  });

  bool get isBreak => timerState == 'breakTime' || timerState == 'breakPaused';

  Color _getStatusColor(BuildContext context) {
    final theme = Theme.of(context);
    switch (timerState) {
      case 'running':
      case 'breakTime':
        return theme.colorScheme.primary;
      case 'paused':
      case 'breakPaused':
        return theme.colorScheme.primary.withOpacity(0.85);
      case 'completed':
        return Colors.green;
      default:
        return theme.colorScheme.primary;
    }
  }

  IconData _getStatusIcon() {
    if (isBreak) return Icons.coffee;
    switch (timerState) {
      case 'running':
        return Icons.local_fire_department;
      case 'paused':
        return Icons.pause_circle_outline;
      case 'completed':
        return Icons.check_circle_outline;
      default:
        return Icons.timer_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer Glow / Ring Container
              Container(
                width: 250.w,
                height: 250.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: statusColor.withOpacity(0.08),
                      blurRadius: 24,
                      spreadRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
              ),

              // Circular Progress Indicator
              SizedBox(
                width: 230.w,
                height: 230.h,
                child: CircularProgressIndicator(
                  value: progressValue,
                  strokeWidth: 9.w,
                  strokeCap: StrokeCap.round,
                  backgroundColor: statusColor.withOpacity(0.12),
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                ),
              ),

              // Content inside Timer
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Status Badge
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _getStatusIcon(),
                          size: 14.sp,
                          color: statusColor,
                        ),
                        6.horizontalSpace,
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.verticalSpace,

                  // Countdown digits
                  Text(
                    timerString,
                    style: TextStyle(
                      fontSize: 44.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      color: theme.textTheme.headlineLarge?.color,
                      fontFeatures: const [
                        FontFeature.tabularFigures(),
                      ],
                    ),
                  ),
                  4.verticalSpace,

                  // Sub-text
                  Text(
                    isBreak
                        ? 'of $selectedBreakMinutes:00 break'
                        : 'of $selectedFocusMinutes:00 focus',
                    style: TextStyle(
                      color: theme.textTheme.bodySmall?.color,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        16.verticalSpace,

        // Live study time tracker badge
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.schedule,
                size: 16.sp,
                color: theme.colorScheme.primary,
              ),
              8.horizontalSpace,
              Text(
                'Total Focused Time: ',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: theme.textTheme.bodySmall?.color,
                ),
              ),
              Text(
                focusedTimeString,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
