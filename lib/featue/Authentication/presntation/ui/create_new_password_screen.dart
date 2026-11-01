import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/shared_wedgits/appBar_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/themes/app_textStyle.dart';
import 'package:focus_flow/gen/assets.gen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/wedgit/create_new_password_widget.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});
  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}
class _CreateNewPasswordScreenState
    extends State<CreateNewPasswordScreen> {
  final formState = GlobalKey<FormState>();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  void dispose() {
    newPassController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }

  void showPasswordChangedAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.password4.image(),
                20.verticalSpace,
                Text(
                  "Password Changed!",
                  style: AppTextstyle.h2.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                10.verticalSpace,
                Text(
                  "Your password has been changed successfully.",
                  style: AppTextstyle.subTitle,
                  textAlign: TextAlign.center,
                ),
                24.verticalSpace,
                MainbuttonWedgit(
                  title: "Back to Login",
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.loginScreen,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: formState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppbarWedgit(),
                20.verticalSpace,
                CreateNewPasswordWidget(
                  newPassController: newPassController,
                  confirmPassController: confirmPassController,
                  formState: formState,
                  onResetPassword: () {
                    showPasswordChangedAlert(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
