
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/themes/cubit/cubit/themecubit_cubit.dart';

class ThemePreviewWidget extends StatelessWidget {
  const ThemePreviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemecubitCubit, ThemecubitState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preview',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
           15.verticalSpace,
            
            MainbuttonWedgit(title: "Focus Flow"),
          ],
        );
      },
    );
  }
}
