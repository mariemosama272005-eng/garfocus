
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';

class AiBannerWidget extends StatelessWidget {
  const AiBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.auto_awesome,
            size: 20.sp,
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Let AI help you create the best plan',
              style: AppTextstyle.hintTextStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}