
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/themes/app_colors.dart';
import 'package:focus_flow/core/themes/cubit/cubit/themecubit_cubit.dart';

class AppearanceScreen extends StatelessWidget {
  const AppearanceScreen({super.key});

  static const List<Color> colors = [
    Color(0xff6C63FF),
    Color(0xff4285F4),
    Color(0xffE76F51),
    Color(0xffD65DB1),
    Color(0xff2A9D8F),
    Color(0xffE9A23B),
    Color(0xff52796F),
    Color(0xff3D5A80),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Appearance'),
        centerTitle: true,
      ),
      body: BlocBuilder<ThemecubitCubit, ThemecubitState>(
        builder: (context, state) {
          Color selectedColor = AppColors.mainColor;

          if (state is ThemecubitInitial) {
            selectedColor = state.color;
          } else if (state is ThemecubitChangeColor) {
            selectedColor = state.color;
          }

          return Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Customize your experience',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  'Choose your favorite app color.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),

                SizedBox(height: 30.h),

                Text(
                  'App Theme Color',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 20.h),

                Wrap(
                  spacing: 20.w,
                  runSpacing: 20.h,
                  children: colors.map((color) {
                    final isSelected = selectedColor.value == color.value;

                    return GestureDetector(
                      onTap: () {
                        context
                            .read<ThemecubitCubit>()
                            .changeColor(color);
                      },
                      child: Container(
                        width: 55.w,
                        height: 55.w,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: isSelected
                              ? Border.all(
                                  color: Colors.black,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 40.h),

                Text(
                  'Preview',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 15.h),

                  MainbuttonWedgit(title: "Focus Flow")
                
              ],
            ),
          );
        },
      ),
    );
  }
}
