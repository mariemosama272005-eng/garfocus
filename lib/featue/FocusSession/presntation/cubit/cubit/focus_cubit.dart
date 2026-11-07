import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_flow/core/services/local/local_helper.dart';
import 'package:focus_flow/featue/FocusSession/data/models/focus_model.dart';
import 'package:focus_flow/featue/Home/data/repo/gamification_repo.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:just_audio/just_audio.dart';

class FocusCubit extends Cubit<FocusStateModel> {
  final TaskCubitCubit? taskCubit;
  Timer? _timer;
  DateTime? _lastTickTime;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isDisposed = false;

  // Break recommendation milestones in seconds:
  // 25m = 1500s, 50m = 3000s, 90m = 5400s
  static const List<int> _breakMilestones = [1500, 3000, 5400];

  FocusCubit({
    TaskModel? task,
    this.taskCubit,
  }) : super(FocusStateModel(task: task)) {
    emit(state.copyWith(remainingSeconds: state.totalFocusTime));
  }

  Future<void> prepareAudio() async {
    if (state.audioPrepared || _isDisposed) return;
    try {
      await _audioPlayer.setAsset('assets/sounds/sound.mp3');
      await _audioPlayer.setVolume(1.0);
      if (!_isDisposed) {
        emit(state.copyWith(audioPrepared: true));
      }
    } catch (e) {
      debugPrint('AUDIO PREPARE ERROR: $e');
      if (!_isDisposed) {
        emit(state.copyWith(audioPrepared: false));
      }
    }
  }

  Future<void> playAlarmSound() async {
    try {
      if (!state.audioPrepared) {
        await prepareAudio();
      }
      if (!state.audioPrepared || _isDisposed) return;

      await _audioPlayer.stop();
      await _audioPlayer.seek(Duration.zero);
      unawaited(_audioPlayer.play());
    } catch (e) {
      debugPrint('AUDIO ERROR: $e');
    }
  }

  void _startPeriodicTimer() {
    _timer?.cancel();
    _lastTickTime = DateTime.now();

    _timer = Timer.periodic(const Duration(seconds: 1), (timerInstance) {
      if (_isDisposed) {
        timerInstance.cancel();
        return;
      }
      _onTick();
    });
  }

  void _onTick() {
    final now = DateTime.now();
    final elapsed = _lastTickTime != null
        ? now.difference(_lastTickTime!).inSeconds
        : 1;

    if (elapsed <= 0) return;
    _lastTickTime = now;

    if (state.currentState == TimerStateEnum.running) {
      _processFocusTick(elapsed);
    } else if (state.currentState == TimerStateEnum.breakTime) {
      _processBreakTick(elapsed);
    }
  }

  void _processFocusTick(int elapsed) {
    final newStudySeconds = state.focusedStudySeconds + elapsed;
    final newRemaining = (state.remainingSeconds - elapsed).clamp(0, state.totalFocusTime);

    // Check if continuous study reached a break milestone
    int triggeredMilestone = 0;
    for (final milestone in _breakMilestones) {
      if (newStudySeconds >= milestone && state.lastPromptedMilestone < milestone) {
        triggeredMilestone = milestone;
        break; // trigger the lowest unprompted milestone
      }
    }

    if (triggeredMilestone > 0) {
      _timer?.cancel();
      unawaited(playAlarmSound());

      emit(state.copyWith(
        currentState: TimerStateEnum.paused,
        focusedStudySeconds: newStudySeconds,
        remainingSeconds: newRemaining,
        lastPromptedMilestone: triggeredMilestone,
        showBreakRecommendation: true,
      ));
      return;
    }

    if (newRemaining <= 0) {
      // Focus countdown interval finished
      _timer?.cancel();
      unawaited(playAlarmSound());

      emit(state.copyWith(
        currentState: TimerStateEnum.paused,
        remainingSeconds: 0,
        focusedStudySeconds: newStudySeconds,
        showBreakRecommendation: true,
      ));
      return;
    }

    emit(state.copyWith(
      remainingSeconds: newRemaining,
      focusedStudySeconds: newStudySeconds,
    ));
  }

  void _processBreakTick(int elapsed) {
    final newBreakRemaining =
        (state.breakRemainingSeconds - elapsed).clamp(0, state.totalBreakSeconds);

    if (newBreakRemaining <= 0) {
      // Break is complete!
      _timer?.cancel();
      unawaited(playAlarmSound());

      emit(state.copyWith(
        currentState: TimerStateEnum.paused,
        breakRemainingSeconds: 0,
        showBreakCompleted: true,
      ));
      return;
    }

    emit(state.copyWith(
      breakRemainingSeconds: newBreakRemaining,
    ));
  }

  /// Called when app returns from background to sync elapsed seconds accurately
  void syncElapsedOnResume() {
    if (state.currentState == TimerStateEnum.running ||
        state.currentState == TimerStateEnum.breakTime) {
      _onTick();
    }
  }

  Future<void> onStartPressed() async {
    await prepareAudio();
    emit(state.copyWith(
      currentState: TimerStateEnum.running,
      showBreakRecommendation: false,
      showBreakCompleted: false,
    ));
    _startPeriodicTimer();
  }

  void pauseTimer() {
    _timer?.cancel();
    emit(state.copyWith(currentState: TimerStateEnum.paused));
  }

  void resumeTimer() {
    emit(state.copyWith(
      currentState: TimerStateEnum.running,
      showBreakRecommendation: false,
      showBreakCompleted: false,
    ));
    _startPeriodicTimer();
  }

  void resetTimer() {
    _timer?.cancel();
    emit(state.copyWith(
      currentState: TimerStateEnum.ready,
      remainingSeconds: state.totalFocusTime,
      showBreakRecommendation: false,
      showBreakCompleted: false,
    ));
  }

  /// Changes focus duration and automatically sets the corresponding break duration:
  /// 25 min -> 5 min break
  /// 45 min -> 10 min break
  /// 60 min -> 15 min break
  /// 90 min -> 15 min break
  void changeFocusDuration(int? minutes) {
    if (minutes == null) return;
    _timer?.cancel();
    final newFocusTime = minutes * 60;
    final autoBreakMinutes = FocusStateModel.defaultBreakForFocusMinutes(minutes);

    emit(state.copyWith(
      selectedFocusMinutes: minutes,
      remainingSeconds: newFocusTime,
      breakRemainingSeconds: autoBreakMinutes * 60,
      totalBreakSeconds: autoBreakMinutes * 60,
      currentState: TimerStateEnum.ready,
      showBreakRecommendation: false,
      showBreakCompleted: false,
    ));
  }

  /// Starts dedicated break timer automatically based on the current focus session
  Future<void> startBreak([int? customMinutes]) async {
    await prepareAudio();
    _timer?.cancel();

    final breakMins = customMinutes ?? state.selectedBreakMinutes;
    final totalBreak = breakMins * 60;

    emit(state.copyWith(
      currentState: TimerStateEnum.breakTime,
      breaksTakenCount: state.breaksTakenCount + 1,
      breakRemainingSeconds: totalBreak,
      totalBreakSeconds: totalBreak,
      showBreakRecommendation: false,
      showBreakCompleted: false,
    ));

    _startPeriodicTimer();
  }

  void pauseBreak() {
    _timer?.cancel();
    emit(state.copyWith(currentState: TimerStateEnum.breakPaused));
  }

  void resumeBreak() {
    emit(state.copyWith(currentState: TimerStateEnum.breakTime));
    _startPeriodicTimer();
  }

  void skipBreak() {
    _timer?.cancel();
    emit(state.copyWith(
      currentState: TimerStateEnum.paused,
      remainingSeconds: state.remainingSeconds > 0
          ? state.remainingSeconds
          : state.totalFocusTime,
      showBreakCompleted: false,
      showBreakRecommendation: false,
    ));
  }

  /// User chooses to postpone break and continue studying
  void continueStudying() {
    emit(state.copyWith(
      showBreakRecommendation: false,
      showBreakCompleted: false,
      currentState: TimerStateEnum.running,
      remainingSeconds: state.remainingSeconds > 0
          ? state.remainingSeconds
          : state.totalFocusTime,
    ));
    _startPeriodicTimer();
  }

  void dismissBreakDialogs() {
    emit(state.copyWith(
      showBreakRecommendation: false,
      showBreakCompleted: false,
    ));
  }

  /// Marks task as completed in Hive, records gamification rewards, and prepares summary
  Future<void> completeTimer() async {
    if (state.isCompleting) return;

    _timer?.cancel();
    emit(state.copyWith(isCompleting: true));

    try {
      if (state.task != null) {
        final task = state.task!;
        task.completeTask();

        // Award gamification XP if not already claimed
        if (!task.rewardClaimed) {
          task.rewardClaimed = true;
          if (LocalHelper.prefs != null) {
            final gamificationRepo =
                GamificationRepository(LocalHelper.prefs!);
            await gamificationRepo.completeTaskReward();
          }
        }

        // Save task in Hive box
        if (task.isInBox) {
          await task.save();
        } else {
          final isBoxOpen = Hive.isBoxOpen('tasksBox');
          final box = isBoxOpen ? Hive.box<TaskModel>('tasksBox') : null;
          if (box != null && task.key != null && box.containsKey(task.key)) {
            final boxTask = box.get(task.key);
            boxTask?.completeTask();
            boxTask?.rewardClaimed = true;
            await boxTask?.save();
          }
        }

        // Refresh task cubit if provided
        taskCubit?.getTasks();
      }

      await playAlarmSound();

      final motivationalMessage = _getMotivationalMessage(state.focusedStudySeconds);

      emit(state.copyWith(
        currentState: TimerStateEnum.completed,
        isCompleting: false,
        showSessionSummary: true,
        motivationalMessage: motivationalMessage,
      ));
    } catch (e, stackTrace) {
      debugPrint('COMPLETE SESSION ERROR: $e');
      debugPrint(stackTrace.toString());
      emit(state.copyWith(isCompleting: false));
    }
  }

  String _getMotivationalMessage(int studySeconds) {
    final minutes = studySeconds ~/ 60;
    if (minutes >= 120) {
      return "Incredible dedication! Over 2 hours of pure focus. You are operating at an elite level!";
    } else if (minutes >= 90) {
      return "Phenomenal focus! 90+ minutes of deep work is how mastery is built. Keep up this momentum!";
    } else if (minutes >= 50) {
      return "Superb effort! You stayed focused for nearly an hour. Consistency builds extraordinary results!";
    } else if (minutes >= 25) {
      return "Outstanding session! Every focused block of time moves you closer to your grandest goals.";
    } else if (minutes > 0) {
      return "Great job focusing! Every single minute invested in your goals compounds into excellence.";
    } else {
      return "Task completed! Consistency is the key to unlocking your highest potential.";
    }
  }

  @override
  Future<void> close() {
    _isDisposed = true;
    _timer?.cancel();
    _audioPlayer.dispose();
    return super.close();
  }
}
