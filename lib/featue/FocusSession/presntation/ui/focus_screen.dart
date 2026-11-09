import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/featue/FocusSession/data/models/focus_model.dart';
import 'package:focus_flow/featue/FocusSession/presntation/cubit/cubit/focus_cubit.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/focusDialog_widget.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/focus_widget.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

class FocusScreen extends StatefulWidget {
  final TaskModel? task;
  final TaskCubitCubit? taskCubit;

  const FocusScreen({
    super.key,
    this.task,
    this.taskCubit,
  });

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> with WidgetsBindingObserver {
  bool _isBreakRecommendationOpen = false;
  bool _isBreakOverOpen = false;
  bool _isSummaryOpen = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      context.read<FocusCubit>().syncElapsedOnResume();
    }
  }

  void _handleNavigateBack() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, true);
    } else {
      Navigator.pushReplacementNamed(
        context,
        AppRoutes.bottomNavbarScreen,
        arguments: {'initialIndex': 1},
      );
    }
  }

  Future<bool> _onWillPop(FocusStateModel state) async {
    final hasActiveProgress =
        state.currentState == TimerStateEnum.running ||
        state.currentState == TimerStateEnum.breakTime ||
        state.focusedStudySeconds > 0;

    if (!hasActiveProgress) {
      return true;
    }

    final shouldLeave = await FocusDialogs.showExitConfirmDialog(
      context,
      studyTime: state.focusedTimeString,
    );

    return shouldLeave;
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FocusCubit>();

    return BlocConsumer<FocusCubit, FocusStateModel>(
      listenWhen: (previous, current) {
        return previous.showBreakRecommendation != current.showBreakRecommendation ||
            previous.showBreakCompleted != current.showBreakCompleted ||
            previous.showSessionSummary != current.showSessionSummary;
      },
      listener: (context, state) {
        // Smart Break Recommendation Trigger
        if (state.showBreakRecommendation && !_isBreakRecommendationOpen) {
          _isBreakRecommendationOpen = true;
          FocusDialogs.showBreakRecommendationDialog(
            context,
            studyMinutes: state.focusedStudySeconds ~/ 60,
            recommendedBreakMinutes: state.recommendedBreakMinutes,
            onStartBreak: () {
              _isBreakRecommendationOpen = false;
              cubit.startBreak();
            },
            onContinueStudying: () {
              _isBreakRecommendationOpen = false;
              cubit.continueStudying();
            },
          );
        }

        // Break Over Trigger
        if (state.showBreakCompleted && !_isBreakOverOpen) {
          _isBreakOverOpen = true;
          FocusDialogs.showBreakOverDialog(
            context,
            onResumeFocus: () {
              _isBreakOverOpen = false;
              cubit.skipBreak();
              cubit.onStartPressed();
            },
            onCompleteSession: () {
              _isBreakOverOpen = false;
              cubit.completeTimer();
            },
          );
        }

        // Focus Session Summary Trigger
        if (state.showSessionSummary && !_isSummaryOpen) {
          _isSummaryOpen = true;
          FocusDialogs.showSessionSummaryDialog(
            context,
            state: state,
            onDismiss: () {
              _isSummaryOpen = false;
              _handleNavigateBack();
            },
          );
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) async {
            if (didPop) return;
            final canLeave = await _onWillPop(state);
            if (canLeave && context.mounted) {
              _handleNavigateBack();
            }
          },
          child: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SafeArea(
              child: FocusWidget(
                task: state.task ?? widget.task,
                timerString: state.timerString,
                progressValue: state.progressValue,
                statusText: state.statusText,
                timerState: state.stateName,
                activeStepIndex: state.activeStepIndex,
                selectedFocusMinutes: state.selectedFocusMinutes,
                selectedBreakMinutes: state.selectedBreakMinutes,
                focusedTimeString: state.focusedTimeString,
                onFocusDurationChanged: cubit.changeFocusDuration,
                onStart: cubit.onStartPressed,
                onPause: cubit.pauseTimer,
                onResume: cubit.resumeTimer,
                onBreak: ([mins]) => cubit.startBreak(mins),
                onEnd: cubit.resetTimer,
                onComplete: cubit.completeTimer,
                onSkipBreak: cubit.skipBreak,
                onPauseBreak: cubit.pauseBreak,
                onResumeBreak: cubit.resumeBreak,
                onBackPressed: () async {
                  final canLeave = await _onWillPop(state);
                  if (canLeave && context.mounted) {
                    _handleNavigateBack();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
