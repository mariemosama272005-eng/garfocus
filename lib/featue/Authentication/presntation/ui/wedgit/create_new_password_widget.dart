
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/textForm_wedgit.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/core/utils/app_validator.dart';
import 'package:focus_flow/gen/assets.gen.dart';

class CreateNewPasswordWidget extends StatelessWidget {
  final TextEditingController newPassController;
  final TextEditingController confirmPassController;
  final GlobalKey<FormState> formState;
  final VoidCallback onResetPassword;

  const CreateNewPasswordWidget({
    super.key,
    required this.newPassController,
    required this.confirmPassController,
    required this.formState,
    required this.onResetPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Assets.images.password3.image(),
        ),
        24.verticalSpace,
        Text(
          "Create new password",
          style: AppTextstyle.h1,
        ),
        8.verticalSpace,
        Text(
          "Your new password must be unique from those previously used.",
          style: AppTextstyle.subTitle,
        ),
        32.verticalSpace,
        TextformWedgit(
          controller: newPassController,
          hintT: "New Password",
          isPass: true,
          validator: (v) {
            if (v == null || v.isEmpty) {
              return "Password is required";
            }
            if (!AppValidator.isPasswordValid(v)) {
              return "Please enter valid Password";
            }
            return null;
          },
        ),
        15.verticalSpace,
        TextformWedgit(
          controller: confirmPassController,
          hintT: "Confirm Password",
          isPass: true,
          validator: (v) {
            if (v == null || v.isEmpty) {
              return "Password is required";
            }
            if (v != newPassController.text) {
              return "Passwords do not match";
            }
            return null;
          },
        ),
        40.verticalSpace,
        MainbuttonWedgit(
          title: "Reset Password",
          onTap: () {
            if (formState.currentState?.validate() ?? false) {
              onResetPassword();
            }
          },
        ),
      ],
    );
  }
}
