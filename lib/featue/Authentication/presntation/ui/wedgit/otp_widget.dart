import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/themes/app_colors.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/gen/assets.gen.dart';

class OtpWidget extends StatelessWidget {
  final VoidCallback onVerify;

  const OtpWidget({super.key, required this.onVerify});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppbarWedgit(),
          20.verticalSpace,
          Center(
            child: Assets.images.password2.image(),
          ),
          24.verticalSpace,
          Text(
            "OTP Verification",
            style: AppTextstyle.h1,
          ),
          8.verticalSpace,
          Text(
            "Enter the verification code we just sent on your email address.",
            style: AppTextstyle.subTitle,
          ),
          32.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              5,
              (index) => SizedBox(
                width: 50.w,
                height: 60.h,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  cursorColor: AppColors.mainColor,
                  decoration: InputDecoration(
                    counterText: "",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: AppColors.borderColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: AppColors.mainColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
          40.verticalSpace,
          MainbuttonWedgit(
            title: "Verify",
            onTap: onVerify,
          ),
        ],
      ),
    );
  }
}