import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/widgets/aiStep_widget.dart';

class AiStepsContainerWidget extends StatelessWidget {
  const AiStepsContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final outlineColor = Theme.of(context).colorScheme.outline;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        color: outlineColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: outlineColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: const [
          AiStep(text: 'Understanding your task'),
          AiStep(text: 'Choosing the right category'),
          AiStep(text: 'Setting the best time'),
          AiStep(text: 'Creating your plan'),
        ],
      ),
    );
  }
}


