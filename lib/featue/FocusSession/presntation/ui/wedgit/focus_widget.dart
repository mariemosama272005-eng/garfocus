import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/Timer_widget.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/currentTask_widget.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/focusAction_widget.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/prograssIn_widget.dart';

class FocusWidget extends StatelessWidget {
  final String timerString;
  final double progressValue;
  final String statusText;
  final String timerState;
  final int activeStepIndex;

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

  const FocusWidget({
    super.key,
    required this.timerString,
    required this.progressValue,
    required this.statusText,
    required this.timerState,
    required this.activeStepIndex,
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
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppbarWedgit(),
          20.verticalSpace,
          const CurrentTaskCardWidget(),
          30.verticalSpace,
          TimerCircularIndicator(
            progressValue: progressValue,
            statusText: statusText,
            timerString: timerString,
            timerState: timerState,
            selectedBreakMinutes: selectedBreakMinutes,
            selectedFocusMinutes: selectedFocusMinutes,
          ),
          20.verticalSpace,
          ProgressStepsIndicator(activeStepIndex: activeStepIndex),
          40.verticalSpace,
          Center(
            child: FocusActionButtonsManager(
              timerState: timerState,
              selectedFocusMinutes: selectedFocusMinutes,
              selectedBreakMinutes: selectedBreakMinutes,
              onFocusDurationChanged: onFocusDurationChanged,
              onStart: onStart,
              onPause: onPause,
              onResume: onResume,
              onBreak: onBreak,
              onEnd: onEnd,
              onComplete: onComplete,
              onSkipBreak: onSkipBreak,
            ),
          ),
        ],
      ),
    );
  }
}





