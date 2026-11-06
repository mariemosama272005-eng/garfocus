
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/gen/assets.gen.dart';

class DolphinCharacterWidget extends StatelessWidget {
  final int level;

  const DolphinCharacterWidget({
    super.key,
    required this.level,
  });

  String get characterMessage {
    switch (level.clamp(1, 5)) {
      case 1:
        return "Let's start our journey!";
      case 2:
        return "You're making progress!";
      case 3:
        return "Look how far we've come!";
      case 4:
        return "You're becoming a focus star!";
      default:
        return "You're a FocusFlow champion!";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Focus Buddy',
                style: TextStyle(
                  fontSize: 19.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF30205D),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                characterMessage,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        Assets.images.repot.image(
          width: 125.w,
          height: 135.h,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
