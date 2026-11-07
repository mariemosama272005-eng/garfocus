import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:focus_flow/featue/FocusSession/data/models/focus_model.dart';
import 'package:focus_flow/featue/FocusSession/presntation/cubit/cubit/focus_cubit.dart';

import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/focusDialog_widget.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/focus_widget.dart';

class FocusScreen extends StatelessWidget {
  const FocusScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    final cubit =
        context.read<FocusCubit>();

    void handleFocusComplete() {
      FocusDialogs.showFocusCompleteDialog(
        context,
      );
    }

    void handleBreakComplete() {
      FocusDialogs.showBreakOverDialog(
        context,
        onOkPressed: () {
          cubit.endTimer();
        },
      );
    }

    return Scaffold(
      backgroundColor:
          Theme.of(context)
              .scaffoldBackgroundColor,

      body: SafeArea(
        child: BlocBuilder<
            FocusCubit,
            FocusStateModel>(
          builder: (
            context,
            state,
          ) {
            return FocusWidget(
              timerString:
                  state.timerString,

              progressValue:
                  state.progressValue,

              statusText:
                  state.statusText,

              timerState:
                  state.stateName,

              activeStepIndex:
                  state.activeStepIndex,

              selectedFocusMinutes:
                  state.selectedFocusMinutes,

              selectedBreakMinutes:
                  state.selectedBreakMinutes,

              onFocusDurationChanged:
                  cubit.changeFocusDuration,

              onStart: () {
                cubit.onStartPressed(
                  handleFocusComplete,
                  handleBreakComplete,
                );
              },

              onPause:
                  cubit.pauseTimer,

              onResume: () {
                cubit.resumeTimer(
                  handleFocusComplete,
                  handleBreakComplete,
                );
              },

              onBreak: () {
                cubit.startBreak(
                  handleFocusComplete,
                  handleBreakComplete,
                );
              },

              onEnd:
                  cubit.endTimer,

              onComplete: () {
                cubit.completeTimer(
                  handleFocusComplete,
                );
              },

              onSkipBreak:
                  cubit.skipBreak,
            );
          },
        ),
      ),
    );
  }
}