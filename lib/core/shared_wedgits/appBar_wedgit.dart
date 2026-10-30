import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/themes/app_colors.dart';

class AppbarWedgit extends StatelessWidget {
  const AppbarWedgit({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.scaffoldColor,
      leading: Container(
        width: 41.w,
        height: 41.h,
        
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white
        ),
        child: BackButton(onPressed: (){
Navigator.pop(context);
        }),

      ),
    );
  }
}