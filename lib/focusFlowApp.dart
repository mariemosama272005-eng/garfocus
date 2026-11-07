import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_router.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/themes/appTheme.dart';
import 'package:focus_flow/core/themes/cubit/cubit/themecubit_cubit.dart';

class Focusflowapp extends StatelessWidget {
  const Focusflowapp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      child: BlocProvider(
        create: (context) => ThemecubitCubit(),
        child: BlocBuilder<ThemecubitCubit, ThemecubitState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Focus Flow',
              themeMode: _getThemeMode(state.themeMode),
              theme: AppTheme.lightTheme(state.color),
              darkTheme: AppTheme.darkTheme(state.color),
              initialRoute: _getInitialRoute(),
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }
  ThemeMode _getThemeMode(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }


  String _getInitialRoute() {
    return AppRoutes.OnboardingScreen;
    // return AppRoutes.OnboardingScreen;
  }
}