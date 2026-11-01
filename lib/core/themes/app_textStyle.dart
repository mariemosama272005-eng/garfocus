import 'package:flutter/material.dart';
import 'package:focus_flow/core/themes/app_colors.dart';

class AppTextstyle {
  static TextStyle h1 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );

  static TextStyle h2 = TextStyle(
    fontSize: 24,
    color: AppColors.blackColor,
  );

  static TextStyle hint24 = TextStyle(
    fontSize: 24,
    color: AppColors.hintColor,
  );
  static TextStyle hintTextStyle=TextStyle(
    fontSize: 15,
color: AppColors.hintColor,
  );
  
  static TextStyle subTitle = TextStyle(
    fontSize: 15,
    color: AppColors.blackColor,
    height: 1.4,
  );
}