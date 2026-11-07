

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/custumButtom_widget.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/focus_widget.dart';
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
  final VoidCallback onBreak;
  final VoidCallback onEnd;
  final VoidCallback onComplete;
  final VoidCallback onSkipBreak;

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
  });

  @override
  Widget build(BuildContext context) {
    switch (timerState) {
      case 'ready':
        return Column(
          children: [
            Text(
              'Select Focus Duration (Minutes)',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
                color: Colors.grey[700],
              ),
            ),
            12.verticalSpace,
            SizedBox(
              height: 55.h,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  TimeChipWidget(
                    minutes: 25,
                    currentValue: selectedFocusMinutes,
                    onTap: onFocusDurationChanged,
                  ),
                  10.horizontalSpace,
                  TimeChipWidget(
                    minutes: 45,
                    currentValue: selectedFocusMinutes,
                    onTap: onFocusDurationChanged,
                  ),
                  10.horizontalSpace,
                  TimeChipWidget(
                    minutes: 60,
                    currentValue: selectedFocusMinutes,
                    onTap: onFocusDurationChanged,
                  ),
                ],
              ),
            ),
            20.verticalSpace,
            Text(
              'Break Duration: $selectedBreakMinutes Minutes',
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            25.verticalSpace,
            CustomActionButton(
              title: 'Start',
              icon: Icons.play_arrow,
              onPressed: onStart,
            ),
          ],
        );

      case 'running':
        return CustomActionButton(
          title: 'Pause',
          icon: Icons.pause,
          onPressed: onPause,
        );

      case 'paused':
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GridActionButton(
                  title: 'Continue',
                  icon: Icons.play_arrow,
                  onPressed: onResume,
                ),
                GridActionButton(
                  title: 'Break',
                  icon: Icons.coffee,
                  onPressed: onBreak,
                ),
              ],
            ),
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GridActionButton(
                  title: 'End',
                  icon: Icons.close,
                  onPressed: onEnd,
                ),
                GridActionButton(
                  title: 'Complete',
                  icon: Icons.check_box_outlined,
                  onPressed: onComplete,
                ),
              ],
            ),
          ],
        );

      case 'breakTime':
        return Column(
          children: [
            Text(
              'Take a Break ☕',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: Colors.purple,
              ),
            ),
            10.verticalSpace,
            Text(
              '$selectedBreakMinutes Minutes Break',
              style: TextStyle(fontSize: 15.sp, color: Colors.grey[700]),
            ),
            25.verticalSpace,
            ElevatedButton.icon(
              onPressed: onSkipBreak,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple.shade200,
                foregroundColor: Colors.black87,
                minimumSize: Size(200.w, 50.h),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              ),
              icon: const Icon(Icons.refresh, size: 18),
              label: Text(
                'Skip Break',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
            ),
          ],
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
