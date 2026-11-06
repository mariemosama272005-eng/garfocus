import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/wedgit/focus_widget.dart';

enum TimerState {
  ready,
  running,
  paused,
  breakTime,
}

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  TimerState currentState = TimerState.ready;

  int selectedFocusMinutes = 25;
  int remainingSeconds = 25 * 60;

  Timer? timer;

  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _audioPrepared = false;

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

  @override
  void initState() {
    super.initState();
    remainingSeconds = totalFocusTime;
  }
  Future<void> prepareAudio() async {
    if (_audioPrepared) return;

    try {
      await _audioPlayer.setAsset(
        'assets/sounds/sound.mp3',
      );

      await _audioPlayer.setVolume(1.0);

      _audioPrepared = true;

      debugPrint('AUDIO: Sound loaded successfully');
    } catch (e) {
      debugPrint('AUDIO PREPARE ERROR: $e');
      _audioPrepared = false;
    }
  }

  Future<void> playAlarmSound() async {
    try {
      if (!_audioPrepared) {
        await prepareAudio();
      }

      if (!_audioPrepared) return;

      await _audioPlayer.stop();
      await _audioPlayer.seek(Duration.zero);

      unawaited(_audioPlayer.play());

      debugPrint('AUDIO: Alarm playback requested');
    } catch (e) {
      debugPrint('AUDIO ERROR: $e');
    }
  }
  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timerInstance) {
        if (!mounted) {
          timerInstance.cancel();
          return;
        }

        if (remainingSeconds > 1) {
          setState(() {
            remainingSeconds--;
          });
        } else {
          timerInstance.cancel();

          setState(() {
            remainingSeconds = 0;
          });

          final finishedState = currentState;

          setState(() {
            currentState = TimerState.paused;
          });

          unawaited(playAlarmSound());

          if (finishedState == TimerState.running) {
            showFocusCompleteDialog();
          } else if (finishedState == TimerState.breakTime) {
            showBreakOverDialog();
          }
        }
      },
    );
  }
  Future<void> onStartPressed() async {
    await prepareAudio();

    if (!mounted) return;

    setState(() {
      currentState = TimerState.running;
    });

    startTimer();
  }
  void pauseTimer() {
    timer?.cancel();

    setState(() {
      currentState = TimerState.paused;
    });
  }
  void resumeTimer() {
    setState(() {
      currentState = TimerState.running;
    });

    startTimer();
  }
  void endTimer() {
    timer?.cancel();

    setState(()
{
      currentState = TimerState.ready;
      remainingSeconds = totalFocusTime;
    });
  }
  void skipBreak() {
    timer?.cancel();

    setState(() {
      currentState = TimerState.ready;
      remainingSeconds = totalFocusTime;
    });
  }
  Future<void> completeTimer() async {
    timer?.cancel();

    setState(() {
      currentState = TimerState.paused;
      remainingSeconds = 0;
    });

    await playAlarmSound();

    if (!mounted) return;

    showFocusCompleteDialog();
  }
  void changeFocusDuration(int? minutes) {
    if (minutes == null) return;

    timer?.cancel();

    setState(() {
      selectedFocusMinutes = minutes;
      remainingSeconds = totalFocusTime;
      currentState = TimerState.ready;
    });
  }
  Future<void> startBreak() async {
    await prepareAudio();

    if (!mounted) return;

    timer?.cancel();

    setState(() {
      currentState = TimerState.breakTime;
      remainingSeconds = totalBreakTime;
    });

    startTimer();
  }
  void showBreakOverDialog() {
    if (!mounted) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('Break Over! 💪'),
        content: const Text(
          'Your break time is over. Ready to get back to work with full focus?',
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);

              setState(() {
                currentState = TimerState.ready;
                remainingSeconds = totalFocusTime;
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
  void showFocusCompleteDialog() {
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            const Text('Outstanding! '),
            Text(
              '🌟',
              style: TextStyle(fontSize: 22.sp),
            ),
          ],
        ),
        content: Text(
          'Every single minute you invest today builds the extraordinary future you deserve. Keep shining!',
          style: TextStyle(
            height: 1.4,
            fontSize: 14.sp,
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 12.h,
              ),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const
               Scaffold(
                    body: Center(
                      child: Text('Home Screen'),
                    ),
                  ),
                ),
              );
            },
            child: Text(
              'Home',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
  String get timerString {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
  double get progressValue {
    final total = currentState == TimerState.breakTime
        ? totalBreakTime
        : totalFocusTime;

    if (total == 0) return 0;

    return remainingSeconds / total;
  }

  String get statusText {
    switch (currentState) {
      case TimerState.ready:
        return 'READY';
      case TimerState.running:
        return 'Focus';
      case TimerState.paused:
        return 'Paused';
      case TimerState.breakTime:
        return 'Break';
    }
  }
  String get stateName {
    switch (currentState) {
      case TimerState.ready:
        return 'ready';
      case TimerState.running:
        return 'running';
      case TimerState.paused:
        return 'paused';
      case TimerState.breakTime:
        return 'breakTime';
    }
  }
  int get activeStepIndex {
    switch (currentState) {
      case TimerState.ready:
        return 0;
      case TimerState.running:
        return 1;
      case TimerState.paused:
        return 2;
      case TimerState.breakTime:
        return 3;
    }
  }
  @override
  void dispose() {
    timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FocusWidget(
          timerString: timerString,
          progressValue: progressValue,
          statusText: statusText,
          timerState: stateName,
          activeStepIndex: activeStepIndex,
          selectedFocusMinutes: selectedFocusMinutes,
          selectedBreakMinutes: selectedBreakMinutes,
          onFocusDurationChanged: changeFocusDuration,
          onStart: onStartPressed,
          onPause: pauseTimer,
          onResume: resumeTimer,
          onBreak: startBreak,
          onEnd: endTimer,
          onComplete: completeTimer,
          onSkipBreak: skipBreak,
        ),
      ),
    );
  }
}