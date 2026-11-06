import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/themes/app_colors.dart';

class OptionTitleWidget extends StatelessWidget {
  final String title;

  const OptionTitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        title,
        style: TextStyle(
          color: 	Theme.of(context).colorScheme.onSurfaceVariant,
          fontSize: 16.sp,
        ),
      ),
    );
  }
}