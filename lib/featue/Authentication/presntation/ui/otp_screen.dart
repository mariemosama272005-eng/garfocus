import 'package:flutter/material.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/wedgit/otp_widget.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OtpWidget(
          onVerify: () {
            Navigator.pushNamed(context, AppRoutes.createNewPasswordScreen);
          },
        ),
      ),
    );
  }
}