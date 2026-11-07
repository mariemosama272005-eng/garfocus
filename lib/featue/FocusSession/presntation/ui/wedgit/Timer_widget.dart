

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimerCircularIndicator extends StatelessWidget {
  final double progressValue;
  final String statusText;
  final String timerString;
  final String timerState;
  final int selectedBreakMinutes;
  final int selectedFocusMinutes;

  const TimerCircularIndicator({
    super.key,
    required this.progressValue,
    required this.statusText,
    required this.timerString,
    required this.timerState,
    required this.selectedBreakMinutes,
    required this.selectedFocusMinutes,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 220.w,
            height: 220.h,
            child: CircularProgressIndicator(
              value: progressValue,
              strokeWidth: 8.w,
              backgroundColor: Colors.purple.shade50,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.purple),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                statusText,
                style: TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              10.verticalSpace,
              Text(
                timerString,
                style: TextStyle(
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              5.verticalSpace,
              Text(
                timerState == 'breakTime'
                    ? 'of $selectedBreakMinutes:00'
                    : 'of $selectedFocusMinutes:00',
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
