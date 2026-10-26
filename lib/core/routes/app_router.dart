import 'package:flutter/material.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/featue/Authentication/presntation/ui/login_screen.dart';
import 'package:focus_flow/featue/Onboarding/presntation/ui/onborading_screen.dart';

class AppRouter {
  static Route? onGenerateRoute(RouteSettings setting){
     switch(setting.name){
      case AppRoutes.OnboardingScreen:
        return MaterialPageRoute(builder:(_)=>OnboardingScreen());
      case AppRoutes.loginScreen:
        return MaterialPageRoute(builder:(_)=>LoginScreen());
     }
     }
  
}