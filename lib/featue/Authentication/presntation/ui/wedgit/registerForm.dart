import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/shared_wedgits/costumButton_wedgit.dart';
import 'package:focus_flow/core/shared_wedgits/textForm_wedgit.dart';
import 'package:focus_flow/core/utils/app_validator.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}
class _RegisterFormState extends State<RegisterForm> {
  var formState = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var confirmPassController = TextEditingController();
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    addressController.dispose();
    cityController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formState,
      child: Column(
        children: [
       
          TextformWedgit(
            controller: nameController,
            hintT: "Username", 
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "Name is required";
              }
              return null;
            },
          ),
          15.verticalSpace,
          
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
            controller: passController,
            hintT: "Enter your password",
            isPass: true,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return"Password is required";
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
            hintT: "Confirm password", 
            isPass: true,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "Password is required";
              }
              if (v != passController.text) {
                return "passwords Not Match";
              }
              return null;
            },
          ),
          15.verticalSpace,
  
          30.verticalSpace,   
          MainbuttonWedgit(
  title: "Register",
  onTap: () {
    if (formState.currentState?.validate() ?? false) {
      Navigator.pushNamed(
        context,
        AppRoutes.homeScreen,
      );
    }
  },
),
        ],
      ),
    );
  }
}