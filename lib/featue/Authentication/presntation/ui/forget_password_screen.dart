import 'package:flutter/material.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/wedgit/forget_password_widget.dart'; 

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}
class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final formState = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:ForgetPasswordWidget(
          formState: formState,
          emailController: emailController,
          onSubmit: () {
            if (formState.currentState?.validate() ?? false) {
              Navigator.pushNamed(context, AppRoutes.otpScreen);
            }
          },
        ),
      ),
    );
  }
}