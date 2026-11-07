import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/Timer_widget.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/currentTask_widget.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/focusAction_widget.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/prograssIn_widget.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';

class FocusWidget extends StatelessWidget {
  final TaskModel? task;
  final String timerString;
  final double progressValue;
  final String statusText;
  final String timerState;
  final int activeStepIndex;
  final int selectedFocusMinutes;
  final int selectedBreakMinutes;
  final String focusedTimeString;
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
  final VoidCallback? onBackPressed;

  const FocusWidget({
    super.key,
    this.task,
    required this.timerString,
    required this.progressValue,
    required this.statusText,
    required this.timerState,
    required this.activeStepIndex,
    required this.selectedFocusMinutes,
    required this.selectedBreakMinutes,
    required this.focusedTimeString,
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
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppbarWedgit(
            title: timerState == 'breakTime' || timerState == 'breakPaused'
                ? 'Break Time'
                : 'Focus Session',
            onBackPressed: onBackPressed,
          ),
          16.verticalSpace,

          // Linked task card
          CurrentTaskCardWidget(task: task),
          24.verticalSpace,

          // Circular timer with live study time indicator (same primary color for both focus and break!)
          TimerCircularIndicator(
            progressValue: progressValue,
            statusText: statusText,
            timerString: timerString,
            timerState: timerState,
            selectedBreakMinutes: selectedBreakMinutes,
            selectedFocusMinutes: selectedFocusMinutes,
            focusedTimeString: focusedTimeString,
          ),
          20.verticalSpace,

          // Progress Steps indicator
          ProgressStepsIndicator(activeStepIndex: activeStepIndex),
          28.verticalSpace,

          // Action buttons
          FocusActionButtonsManager(
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
            onPauseBreak: onPauseBreak,
            onResumeBreak: onResumeBreak,
          ),
          24.verticalSpace,
        ],
      ),
    );
  }
}
