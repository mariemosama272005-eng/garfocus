import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';

class AiInfoTextWidget extends StatelessWidget {
  const AiInfoTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'AI is creating your plan ...',
          textAlign: TextAlign.center,
          style: AppTextstyle.h2(context),
        ),
        18.verticalSpace,
        Text(
          'Analyzing your task, finding the best\n'
          'category, urgency and organizing it\n'
          'into your schedule.',
          textAlign: TextAlign.center,
          style: AppTextstyle.hintTextStyle(context),
        ),
      ],
    );
  }
}


