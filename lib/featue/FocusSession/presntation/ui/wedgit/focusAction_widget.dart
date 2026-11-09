import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/custumButtom_widget.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/gridbuttons_widget.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/timerChip_widget.dart';

class FocusActionButtonsManager extends StatelessWidget {
  final String timerState;
  final int selectedFocusMinutes;
  final int selectedBreakMinutes;
  final Function(int?) onFocusDurationChanged;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final Function([int?]) onBreak;
  final VoidCallback onEnd;
  final VoidCallback onComplete;
  final VoidCallback onSkipBreak;
  final VoidCallback? onPauseBreak;
  final VoidCallback? onResumeBreak;

  const FocusActionButtonsManager({
    super.key,
    required this.timerState,
    required this.selectedFocusMinutes,
    required this.selectedBreakMinutes,
    required this.onFocusDurationChanged,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.onBreak,
    required this.onEnd,
    required this.onComplete,
    required this.onSkipBreak,
    this.onPauseBreak,
    this.onResumeBreak,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    switch (timerState) {
      case 'ready':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Focus Duration Title
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Focus Duration',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                Text(
                  '$selectedFocusMinutes min focus',
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
            10.verticalSpace,

            // Horizontal focus duration chips
            SizedBox(
              height: 72.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  TimeChipWidget(
                    minutes: 15,
                    currentValue: selectedFocusMinutes,
                    onTap: onFocusDurationChanged,
                  ),
                  8.horizontalSpace,
                  TimeChipWidget(
                    minutes: 25,
                    currentValue: selectedFocusMinutes,
                    onTap: onFocusDurationChanged,
                  ),
                  8.horizontalSpace,
                  TimeChipWidget(
                    minutes: 45,
                    currentValue: selectedFocusMinutes,
                    onTap: onFocusDurationChanged,
                  ),
                  8.horizontalSpace,
                  TimeChipWidget(
                    minutes: 60,
                    currentValue: selectedFocusMinutes,
                    onTap: onFocusDurationChanged,
                  ),
                  8.horizontalSpace,
                  TimeChipWidget(
                    minutes: 90,
                    currentValue: selectedFocusMinutes,
                    onTap: onFocusDurationChanged,
                  ),
                ],
              ),
            ),
            18.verticalSpace,

            // Automatic Break indicator card
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.coffee,
                    size: 20.sp,
                    color: primaryColor,
                  ),
                  10.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Automatic Break: $selectedBreakMinutes Minutes',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        2.verticalSpace,
                        Text(
                          'Smart Break: 25m→5m break, 45m→10m break, 60m/90m→15m break.',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: theme.textTheme.bodySmall?.color,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            24.verticalSpace,

            // Start Button
            Center(
              child: CustomActionButton(
                title: 'Start Focus',
                icon: Icons.play_arrow_rounded,
                onPressed: onStart,
                width: 220.w,
              ),
            ),
          ],
        );

      case 'running':
        return Column(
          children: [
            CustomActionButton(
              title: 'Pause Focus',
              icon: Icons.pause_rounded,
              onPressed: onPause,
              width: 200.w,
            ),
            14.verticalSpace,
            TextButton.icon(
              onPressed: onComplete,
              icon: Icon(Icons.check_circle_outline,
                  color: Colors.green.shade700, size: 18.sp),
              label: Text(
                'Complete Task Early',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        );

      case 'paused':
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridActionButton(
                  title: 'Resume',
                  icon: Icons.play_arrow_rounded,
                  onPressed: onResume,
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                ),
                14.horizontalSpace,
                GridActionButton(
                  title: 'Take Break',
                  icon: Icons.coffee_rounded,
                  onPressed: () => onBreak(selectedBreakMinutes),
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
            14.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridActionButton(
                  title: 'Reset',
                  icon: Icons.refresh_rounded,
                  onPressed: onEnd,
                  isOutlined: true,
                ),
                14.horizontalSpace,
                GridActionButton(
                  title: 'Complete',
                  icon: Icons.check_circle_rounded,
                  onPressed: onComplete,
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ],
        );

      case 'breakTime':
        return Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: primaryColor.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.coffee, color: primaryColor, size: 20.sp),
                  10.horizontalSpace,
                  Expanded(
                    child: Text(
                      'Break in progress ($selectedBreakMinutes min). Study timer is paused and will not count towards study time.',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: theme.textTheme.bodyMedium?.color,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (onPauseBreak != null) ...[
                  GridActionButton(
                    title: 'Pause Break',
                    icon: Icons.pause,
                    onPressed: onPauseBreak!,
                    isOutlined: true,
                  ),
                  14.horizontalSpace,
                ],
                CustomActionButton(
                  title: 'Skip Break',
                  icon: Icons.fast_forward_rounded,
                  onPressed: onSkipBreak,
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  width: 170.w,
                ),
              ],
            ),
          ],
        );

      case 'breakPaused':
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (onResumeBreak != null) ...[
                  GridActionButton(
                    title: 'Resume Break',
                    icon: Icons.play_arrow,
                    onPressed: onResumeBreak!,
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  14.horizontalSpace,
                ],
                GridActionButton(
                  title: 'Skip Break',
                  icon: Icons.fast_forward,
                  onPressed: onSkipBreak,
                  isOutlined: true,
                ),
              ],
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
