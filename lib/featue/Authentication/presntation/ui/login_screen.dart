import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/core/themes/app_colors.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/wedgit/loginForm.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          children: [
            AppbarWedgit(),

            Text(
              "Welcome back!\nGlad to see you,\nAgain!",
              style: AppTextstyle.h1,
            ),

            32.verticalSpace,

            LoginForm(),

            const Spacer(),

            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No Account? ",
                    style: AppTextstyle.h2,
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.registerScreen,
                      );
                    },
                    child: Text(
                      "Register Now",
                      style: AppTextstyle.h2.copyWith(
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}