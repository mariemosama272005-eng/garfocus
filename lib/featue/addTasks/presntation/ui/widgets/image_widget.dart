
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/gen/assets.gen.dart';

class AiImageWidget extends StatelessWidget {
  const AiImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175.w,
      height: 150.h,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(35.r),
      ),
      child: Center(
        child: Assets.images.repot.image(),
      ),
    );
  }
}
