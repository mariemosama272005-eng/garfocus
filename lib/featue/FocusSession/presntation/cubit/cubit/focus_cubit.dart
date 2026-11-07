import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_flow/featue/FocusSession/data/models/focus_model.dart';
import 'package:just_audio/just_audio.dart';


class FocusCubit extends Cubit<FocusStateModel> {
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();

  FocusCubit() : super(const FocusStateModel()) {
    emit(state.copyWith(remainingSeconds: state.totalFocusTime));
  }

  Future<void> prepareAudio() async {
    if (state.audioPrepared) return;
    try {
      await _audioPlayer.setAsset('assets/sounds/sound.mp3');
      await _audioPlayer.setVolume(1.0);
      emit(state.copyWith(audioPrepared: true));
    } catch (e) {
      debugPrint('AUDIO PREPARE ERROR: $e');
      emit(state.copyWith(audioPrepared: false));
    }
  }

  Future<void> playAlarmSound() async {
    try {
      if (!state.audioPrepared) {
        await prepareAudio();
      }
      if (!state.audioPrepared) return;

      await _audioPlayer.stop();
      await _audioPlayer.seek(Duration.zero);
      unawaited(_audioPlayer.play());
    } catch (e) {
      debugPrint('AUDIO ERROR: $e');
    }
  }

  void startTimer(VoidCallback onFocusComplete, VoidCallback onBreakComplete) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timerInstance) {
      if (state.remainingSeconds > 1) {
        emit(state.copyWith(remainingSeconds: state.remainingSeconds - 1));
      } else {
        timerInstance.cancel();
        final finishedState = state.currentState;

        emit(state.copyWith(
          remainingSeconds: 0,
          currentState: TimerStateEnum.paused,
        ));

        unawaited(playAlarmSound());

        if (finishedState == TimerStateEnum.running) {
          onFocusComplete();
        } else if (finishedState == TimerStateEnum.breakTime) {
          onBreakComplete();
        }
      }
    });
  }

  Future<void> onStartPressed(VoidCallback onFocusComplete, VoidCallback onBreakComplete) async {
    await prepareAudio();
    emit(state.copyWith(currentState: TimerStateEnum.running));
    startTimer(onFocusComplete, onBreakComplete);
  }

  void pauseTimer() {
    _timer?.cancel();
    emit(state.copyWith(currentState: TimerStateEnum.paused));
  }

  void resumeTimer(VoidCallback onFocusComplete, VoidCallback onBreakComplete) {
    emit(state.copyWith(currentState: TimerStateEnum.running));
    startTimer(onFocusComplete, onBreakComplete);
  }

  void endTimer() {
    _timer?.cancel();
    emit(state.copyWith(
      currentState: TimerStateEnum.ready,
      remainingSeconds: state.totalFocusTime,
    ));
  }

  void skipBreak() {
    endTimer();
  }

  Future<void> completeTimer(VoidCallback onFocusComplete) async {
    _timer?.cancel();
    emit(state.copyWith(
      currentState: TimerStateEnum.paused,
      remainingSeconds: 0,
    ));
    await playAlarmSound();
    onFocusComplete();
  }

  void changeFocusDuration(int? minutes) {
    if (minutes == null) return;
    _timer?.cancel();
    final newFocusTime = minutes * 60;
    emit(state.copyWith(
      selectedFocusMinutes: minutes,
      remainingSeconds: newFocusTime,
      currentState: TimerStateEnum.ready,
    ));
  }

  Future<void> startBreak(VoidCallback onFocusComplete, VoidCallback onBreakComplete) async {
    await prepareAudio();
    _timer?.cancel();
    final newBreakTime = state.selectedBreakMinutes * 60;
    emit(state.copyWith(
      currentState: TimerStateEnum.breakTime,
      remainingSeconds: newBreakTime,
    ));
    startTimer(onFocusComplete, onBreakComplete);
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}