import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';

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
      padding: EdgeInsets.all(22.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppbarWedgit(),

          20.verticalSpace,

          // Current Task
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Text(
                  '✍️',
                  style: TextStyle(fontSize: 20.sp),
                ),

                10.horizontalSpace,

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Working on',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),

                    Text(
                      'Study Flutter',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          30.verticalSpace,

          // Timer Circle
          Center(
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
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(
                      Colors.purple,
                    ),
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
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          20.verticalSpace,

          // Progress Steps
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isActive = index == activeStepIndex;

                return Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 4.w,
                  ),
                  width: isActive ? 20.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.purple
                        : Colors.purple.shade100,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                );
              }),
            ),
          ),

          40.verticalSpace,

          Center(
            child: _buildActionButtons(),
          ),
        ],
      ),
    );
  }
  Widget _buildActionButtons() {
    // READY
    if (timerState == 'ready') {
      return Column(
        children: [
          Text(
            'Select Focus Duration (Minutes)',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
              color: Colors.grey[700],
            ),
          ),

          12.verticalSpace,

          SizedBox(
            height: 55.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              children: [
                _buildTimeChip(
                  25,
                  selectedFocusMinutes,
                  onFocusDurationChanged,
                ),

                10.horizontalSpace,

                _buildTimeChip(
                  45,
                  selectedFocusMinutes,
                  onFocusDurationChanged,
                ),

                10.horizontalSpace,

                _buildTimeChip(
                  60,
                  selectedFocusMinutes,
                  onFocusDurationChanged,
                ),
              ],
            ),
          ),

          20.verticalSpace,

          Text(
            'Break Duration: $selectedBreakMinutes Minutes',
            style: TextStyle(
              color: Colors.purple,
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
            ),
          ),

          25.verticalSpace,

          _customButton(
            title: 'Start',
            icon: Icons.play_arrow,
            onPressed: onStart,
          ),
        ],
      );
    }

    // RUNNING
    else if (timerState == 'running') {
      return _customButton(
        title: 'Pause',
        icon: Icons.pause,
        onPressed: onPause,
      );
    }

    // PAUSED
    else if (timerState == 'paused') {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _gridButton(
                title: 'Continue',
                icon: Icons.play_arrow,
                onPressed: onResume,
              ),

              _gridButton(
                title: 'Break',
                icon: Icons.coffee,
                onPressed: onBreak,
              ),
            ],
          ),

          20.verticalSpace,

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _gridButton(
                title: 'End',
                icon: Icons.close,
                onPressed: onEnd,
              ),

              _gridButton(
                title:
                'Complete',
                icon: Icons.check_box_outlined,
                onPressed: onComplete,
              ),
            ],
          ),
        ],
      );
    }

    // BREAK
    else if (timerState == 'breakTime') {
      return Column(
        children: [
          Text(
            'Take a Break ☕',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              color: Colors.purple,
            ),
          ),
          10.verticalSpace,
          Text(
            '$selectedBreakMinutes Minutes Break',
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey[700],
            ),
          ),

          25.verticalSpace,
          ElevatedButton.icon(
            onPressed: onSkipBreak,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple.shade200,
              foregroundColor: Colors.black87,
              minimumSize: Size(200.w, 50.h),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
            ),
            icon: const Icon(
              Icons.refresh,
              size: 18,
            ),
            label: Text(
              'Skip Break',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
  Widget _buildTimeChip(
    int minutes,
    int currentValue,
    Function(int?) onTap,
  ) {
    final isSelected = currentValue == minutes;

    return GestureDetector(
      onTap: () => onTap(minutes),
      child: Container(
        width: 65.w,
        height: 52.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.purple
              : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? Colors.purple
                : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          '$minutes',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: isSelected
                ? Colors.white
                : Colors.black87,
          ),
        ),
      ),
    );
  }
  Widget _customButton({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple.shade200,
        foregroundColor: Colors.black87,
        minimumSize: Size(160.w, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),

          10.horizontalSpace,

          Icon(
            icon,
            size: 20.sp,
          ),
        ],
      ),
    );
  }

  Widget _gridButton({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple.shade200,
        foregroundColor:
      Colors.black87,
        fixedSize: Size(155.w, 55.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        elevation: 0,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),

          Icon(
            icon,
            size: 20.sp,
          ),
        ],
      ),
    );
  }
}