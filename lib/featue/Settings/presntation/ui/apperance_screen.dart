
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/featue/Settings/presntation/ui/wedgit/color_picker_widget.dart';
import 'package:focus_flow/featue/Settings/presntation/ui/wedgit/theme_mode_selector.dart';
import 'package:focus_flow/featue/Settings/presntation/ui/wedgit/theme_preview_widget.dart';



class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: 
      SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppbarWedgit(title: "Apperance"),
              Text(
                'Customize your experience',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8.h),

              Text(
                'Choose your favorite app appearance.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
              ),

              SizedBox(height: 30.h),

              const ThemeModeSelector(),

              SizedBox(height: 30.h),

              const ColorPickerWidget(),

              SizedBox(height: 35.h),

              const ThemePreviewWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
