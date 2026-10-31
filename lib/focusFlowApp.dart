
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_router.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/themes/app_colors.dart';

class Focusflowapp extends StatelessWidget {
  const Focusflowapp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
         title: 'Focus Flow',
        theme: ThemeData(
          fontFamily:'inter',
          scaffoldBackgroundColor: AppColors.scaffoldColor),
            initialRoute: intialPage(),
      onGenerateRoute: AppRouter.onGenerateRoute,
        
      ),
    );
  } String intialPage(){
    //return AppRoutes.OnboardingScreen;
    return AppRoutes.addTaskScreen;
  }

}
