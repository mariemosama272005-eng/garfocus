import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/textForm_wedgit.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/core/utils/app_validator.dart';
import 'package:focus_flow/gen/assets.gen.dart';

class ForgetPasswordWidget extends StatelessWidget {
  final GlobalKey<FormState> formState;
  final TextEditingController emailController;
  final VoidCallback onSubmit;

  const ForgetPasswordWidget({
    super.key,
    required this.formState,
    required this.emailController,
    required this.onSubmit,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(22),
      child: Form(
        key: formState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppbarWedgit(),
            20.verticalSpace,
            Center(
              child: Assets.images.password1.image(),
            ),
            24.verticalSpace,
            Text(
              "Forget Password?",
              style: AppTextstyle.h1,
            ),
            8.verticalSpace,
            Text(
              "Enter your email or phone number to receive a reset link.",
              style: AppTextstyle.subTitle,
            ),
            32.verticalSpace,
            TextformWedgit(
              controller: emailController,
              hintT: "Enter your email",
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Email is required";
                }
                if (!AppValidator.isValidEmail(v)) {
                  return "Please Enter valid Email";
                }
                return null;
              },
            ),
            40.verticalSpace,
            MainbuttonWedgit(
              title: "Send code",
              onTap: onSubmit,
            ),
          ],
        ),
      ),
    );
  }
}