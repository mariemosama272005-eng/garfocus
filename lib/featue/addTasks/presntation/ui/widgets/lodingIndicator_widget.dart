import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiLoadingIndicatorWidget extends StatelessWidget {
  const AiLoadingIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25.w,
      height: 25.w,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}