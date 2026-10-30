
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/themes/app_colors.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';


class MainbuttonWedgit extends StatelessWidget {
  final String title;
  final Color? bgColor;
  final Color? textColor;
  final Function()? onTap;

  const MainbuttonWedgit({
    super.key,
    required this.title,
    this.bgColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bgColor ?? AppColors.mainColor,
            borderRadius: BorderRadius.circular(8.r)
          ), 
          child: Text(title, style:AppTextstyle.hint24.copyWith(
            color: textColor ?? Colors.white
          ),
          ),
        ),
      ),
    ); 
  }
}