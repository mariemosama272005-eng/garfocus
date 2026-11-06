import 'package:flutter/material.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/login_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/register_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/forget_password_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/otp_screen.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/create_new_password_screen.dart';
import 'package:focus_flow/featue/FocusSession/presntation/ui/focus_screen.dart';
import 'package:focus_flow/featue/Home/presntation/ui/home_screen.dart';
import 'package:focus_flow/featue/Onboarding/presntation/ui/onborading_screen.dart';
import 'package:focus_flow/featue/Settings/presntation/ui/apperance_screen.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/addTask_screen.dart';
import 'package:focus_flow/featue/addTasks/presntation/ui/aiCreatingPlan.dart';
import 'package:focus_flow/featue/bottomNavBar/presentation/ui/bottomNavBar_screen.dart';
import 'package:focus_flow/featue/tasks/presentation/ui/task_screen.dart';


class AppRouter {
  static RouteFactory? get onboarding => null;

  static RouteFactory? get focusScreen => null;

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
      case AppRoutes.addTaskScreen:
        return MaterialPageRoute(builder:(_)=>AddTaskScreen());
      case AppRoutes.aiCreatingPlanScreen:
        return MaterialPageRoute(builder:(_)=>AiCreatingPlanScreen());
      case AppRoutes.apperanceScreen:
        return MaterialPageRoute(builder:(_)=>AppearanceScreen());
      case AppRoutes.focusScreen:
        return MaterialPageRoute( builder: (_) => const FocusScreen());
      case AppRoutes.taskScreen:
        return MaterialPageRoute(builder:(_)=>TaskScreen());
      case AppRoutes.bottomNavbarScreen:
        return MaterialPageRoute(builder:(_)=>ButtomNavBarScreen());
      
      
     }
     }
  
}