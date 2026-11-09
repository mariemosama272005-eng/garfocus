enum TimerStateEnum { ready, running, paused, breakTime }

class FocusStateModel {
  final TimerStateEnum currentState;
  final int selectedFocusMinutes;
  final int remainingSeconds;
  final bool audioPrepared;

  const FocusStateModel({
    this.currentState = TimerStateEnum.ready,
    this.selectedFocusMinutes = 25,
    this.remainingSeconds = 25 * 60,
    this.audioPrepared = false,
  });

  int get selectedBreakMinutes {
    switch (selectedFocusMinutes) {
      case 25:
        return 5;
      case 45:
        return 10;
      case 60:
        return 15;
      default:
        return 5;
    }
  }

  int get totalFocusTime => selectedFocusMinutes * 60;
  int get totalBreakTime => selectedBreakMinutes * 60;

  String get timerString {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get progressValue {
    final total = currentState == TimerStateEnum.breakTime ? totalBreakTime : totalFocusTime;
    if (total == 0) return 0;
    return remainingSeconds / total;
  }

  String get statusText {
    switch (currentState) {
      case TimerStateEnum.ready:
        return 'READY';
      case TimerStateEnum.running:
        return 'Focus';
      case TimerStateEnum.paused:
        return 'Paused';
      case TimerStateEnum.breakTime:
        return 'Break';
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
        return 3;
    }
  }

  FocusStateModel copyWith({
    TimerStateEnum? currentState,
    int? selectedFocusMinutes,
    int? remainingSeconds,
    bool? audioPrepared,
  }) {
    return FocusStateModel(
      currentState: currentState ?? this.currentState,
      selectedFocusMinutes: selectedFocusMinutes ?? this.selectedFocusMinutes,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      audioPrepared: audioPrepared ?? this.audioPrepared,
    );
  }
}