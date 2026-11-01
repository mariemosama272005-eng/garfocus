import 'package:flutter/material.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/login_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/register_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/forget_password_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/otp_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/create_new_password_screen.dart';
import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';
import 'package:focus_flow/featue/Onboarding/presntation/ui/onborading_screen.dart';
import 'package:focus_flow/featue/Tasks/presntation/ui/addTask_screen.dart';
import 'package:focus_flow/featue/Tasks/presntation/ui/ai_creating_plan_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRoutes.OnboardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case AppRoutes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case AppRoutes.registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case AppRoutes.forgetpassScreen:
        return MaterialPageRoute(builder: (_) => ForgetPasswordScreen());
      case AppRoutes.otpScreen:
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case AppRoutes.createNewPasswordScreen:
        return MaterialPageRoute(builder: (_) => CreateNewPasswordScreen());
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return null;
    }
  }
        return MaterialPageRoute(builder:(_)=>RegisterScreen());
      case AppRoutes.addTaskScreen:
        return MaterialPageRoute(builder:(_)=>AddTaskScreen());
      case AppRoutes.aiCreatingPlanScreen:
        return MaterialPageRoute(builder:(_)=>AiCreatingPlanScreen());
      
     }
     }
  
}