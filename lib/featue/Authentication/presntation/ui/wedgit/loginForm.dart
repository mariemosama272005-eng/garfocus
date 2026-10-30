import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';

import 'package:focus_flow/core/shared_wedgits/textForm_wedgit.dart';

import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/core/utils/app_validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formState = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passcontroller = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        children: [
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

          15.verticalSpace,

          TextformWedgit(
            controller: passcontroller,
            hintT: "Enter your password",
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

          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.forgetpassScreen,
                );
              },
              child: Text(
                "Forget Password",
                style: AppTextstyle.hintTextStyle,
              ),
            ),
          ),

          30.verticalSpace,

          MainbuttonWedgit(
            title: "Login",
            onTap: () {
              if (formState.currentState?.validate() ?? false) {
               Navigator.pushNamed(context, AppRoutes.homeScreen);
              }
            },
          ),
        ],
      ),
    );
  }
}