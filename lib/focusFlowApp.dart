import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_flow/core/routes/app_router.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
import 'package:focus_flow/core/themes/app_colors.dart';
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
            Color selectedColor;

            if (state is ThemecubitInitial) {
              selectedColor = state.color;
            } else if (state is ThemecubitChangeColor) {
              selectedColor = state.color;
            } else {
              selectedColor = AppColors.mainColor;
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Focus Flow',
              theme: ThemeData(
                fontFamily: 'inter',
                scaffoldBackgroundColor: AppColors.scaffoldColor,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: selectedColor,
                ),
              ),
              initialRoute: intialPage(),
              onGenerateRoute: AppRouter.onGenerateRoute,
            );
          },
        ),
      ),
    );
  }

  String intialPage() {
    return AppRoutes.OnboardingScreen;
  }
}