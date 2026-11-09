import 'package:flutter/material.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';

enum TimerStateEnum { ready, running, paused, breakTime, breakPaused, completed }

class FocusStateModel {
  final TimerStateEnum currentState;
  final TaskModel? task;
  final int selectedFocusMinutes;
  final int remainingSeconds;
  final int focusedStudySeconds;
  final int breaksTakenCount;
  final int breakRemainingSeconds;
  final int totalBreakSeconds;
  final int lastPromptedMilestone;
  final bool audioPrepared;
  final bool isCompleting;
  final bool showBreakRecommendation;
  final bool showBreakCompleted;
  final bool showSessionSummary;
  final String? motivationalMessage;

  const FocusStateModel({
    this.currentState = TimerStateEnum.ready,
    this.task,
    this.selectedFocusMinutes = 25,
    this.remainingSeconds = 25 * 60,
    this.focusedStudySeconds = 0,
    this.breaksTakenCount = 0,
    this.breakRemainingSeconds = 5 * 60,
    this.totalBreakSeconds = 5 * 60,
    this.lastPromptedMilestone = 0,
    this.audioPrepared = false,
    this.isCompleting = false,
    this.showBreakRecommendation = false,
    this.showBreakCompleted = false,
    this.showSessionSummary = false,
    this.motivationalMessage,
  });

  /// Automatic break calculation based on focus duration:
  /// 25 min -> 5 min break
  /// 45 min -> 10 min break
  /// 60 min -> 15 min break
  /// 90 min -> 15 min break
  static int defaultBreakForFocusMinutes(int focusMinutes) {
    if (focusMinutes >= 60) return 15;
    if (focusMinutes >= 45) return 10;
    return 5;
  }

  /// Break duration is strictly automatic based on the focus duration
  int get selectedBreakMinutes => defaultBreakForFocusMinutes(selectedFocusMinutes);

  /// Recommended break minutes based on study progress or focus selection
  int get recommendedBreakMinutes {
    final minutes = focusedStudySeconds ~/ 60;
    if (minutes >= 60) {
      return 15;
    } else if (minutes >= 45) {
      return 10;
    } else if (minutes >= 25) {
      return 5;
    } else {
      return selectedBreakMinutes;
    }
  }

  int get totalFocusTime => selectedFocusMinutes * 60;

  int get totalBreakTime => totalBreakSeconds;

  String get timerString {
    final secondsToFormat = (currentState == TimerStateEnum.breakTime ||
            currentState == TimerStateEnum.breakPaused)
        ? breakRemainingSeconds
        : remainingSeconds;
    final minutes = secondsToFormat ~/ 60;
    final seconds = secondsToFormat % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get focusedTimeString {
    final minutes = focusedStudySeconds ~/ 60;
    final seconds = focusedStudySeconds % 60;
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      final remainingMins = minutes % 60;
      return '${hours}h ${remainingMins}m ${seconds}s';
    }
    return '${minutes}m ${seconds}s';
  }

  String get breakTimeString {
    final minutes = breakRemainingSeconds ~/ 60;
    final seconds = breakRemainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get progressValue {
    if (currentState == TimerStateEnum.breakTime ||
        currentState == TimerStateEnum.breakPaused) {
      if (totalBreakSeconds <= 0) return 0;
      return (breakRemainingSeconds / totalBreakSeconds).clamp(0.0, 1.0);
    }
    if (totalFocusTime <= 0) return 0;
    return (remainingSeconds / totalFocusTime).clamp(0.0, 1.0);
  }

  String get statusText {
    switch (currentState) {
      case TimerStateEnum.ready:
        return 'READY';
      case TimerStateEnum.running:
        return 'FOCUS';
      case TimerStateEnum.paused:
        return 'PAUSED';
      case TimerStateEnum.breakTime:
        return 'BREAK';
      case TimerStateEnum.breakPaused:
        return 'BREAK PAUSED';
      case TimerStateEnum.completed:
        return 'COMPLETED';
    }
  }

  String get stateName {
    switch (currentState) {
      case TimerStateEnum.ready:
        return 'ready';
      case TimerStateEnum.running:
        return 'running';
      case TimerStateEnum.paused:
        return 'paused';
      case TimerStateEnum.breakTime:
        return 'breakTime';
      case TimerStateEnum.breakPaused:
        return 'breakPaused';
      case TimerStateEnum.completed:
        return 'completed';
    }
  }

  int get activeStepIndex {
    switch (currentState) {
      case TimerStateEnum.ready:
        return 0;
      case TimerStateEnum.running:
        return 1;
      case TimerStateEnum.paused:
        return 2;
      case TimerStateEnum.breakTime:
      case TimerStateEnum.breakPaused:
        return 3;
      case TimerStateEnum.completed:
        return 4;
    }
  }

  FocusStateModel copyWith({
    TimerStateEnum? currentState,
    TaskModel? task,
    int? selectedFocusMinutes,
    int? remainingSeconds,
    int? focusedStudySeconds,
    int? breaksTakenCount,
    int? breakRemainingSeconds,
    int? totalBreakSeconds,
    int? lastPromptedMilestone,
    bool? audioPrepared,
    bool? isCompleting,
    bool? showBreakRecommendation,
    bool? showBreakCompleted,
    bool? showSessionSummary,
    String? motivationalMessage,
  }) {
    return FocusStateModel(
      currentState: currentState ?? this.currentState,
      task: task ?? this.task,
      selectedFocusMinutes: selectedFocusMinutes ?? this.selectedFocusMinutes,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      focusedStudySeconds: focusedStudySeconds ?? this.focusedStudySeconds,
      breaksTakenCount: breaksTakenCount ?? this.breaksTakenCount,
      breakRemainingSeconds:
          breakRemainingSeconds ?? this.breakRemainingSeconds,
      totalBreakSeconds: totalBreakSeconds ?? this.totalBreakSeconds,
      lastPromptedMilestone:
          lastPromptedMilestone ?? this.lastPromptedMilestone,
      audioPrepared: audioPrepared ?? this.audioPrepared,
      isCompleting: isCompleting ?? this.isCompleting,
      showBreakRecommendation:
          showBreakRecommendation ?? this.showBreakRecommendation,
      showBreakCompleted: showBreakCompleted ?? this.showBreakCompleted,
      showSessionSummary: showSessionSummary ?? this.showSessionSummary,
      motivationalMessage: motivationalMessage ?? this.motivationalMessage,
    );
  }
}
