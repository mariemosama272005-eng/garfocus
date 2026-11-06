  
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/themes/cubit/cubit/themecubit_cubit.dart';

class ColorPickerWidget extends StatelessWidget {
  const ColorPickerWidget({super.key});

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
    return BlocBuilder<ThemecubitCubit, ThemecubitState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                final isSelected =
                    state.color.value == color.value;

                return GestureDetector(
                  onTap: () {
                    context
                        .read<ThemecubitCubit>()
                        .changeColor(color);
                  },
                  child: Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface,
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
          ],
        );
      },
    );
  }
}
