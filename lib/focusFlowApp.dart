
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:focus_flow/core/routes/app_router.dart';
import 'package:focus_flow/core/routes/app_routes.dart';
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

              themeMode: state.themeMode == AppThemeMode.light
                  ? ThemeMode.light
                  : state.themeMode == AppThemeMode.dark
                      ? ThemeMode.dark
                      : ThemeMode.system,

              // Light Theme
              theme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.light,
                fontFamily: 'inter',

                scaffoldBackgroundColor: const Color(0xffF8F8FA),
                cardColor: Colors.white,

                colorScheme: ColorScheme.fromSeed(
                  seedColor: state.color,
                  brightness: Brightness.light,
                ),

                textTheme: const TextTheme(
                  bodyLarge: TextStyle(
                    color: Color(0xff252525),
                  ),
                  bodyMedium: TextStyle(
                    color: Color(0xff252525),
                  ),
                  bodySmall: TextStyle(
                    color: Color(0xff666666),
                  ),
                  titleLarge: TextStyle(
                    color: Color(0xff252525),
                  ),
                  titleMedium: TextStyle(
                    color: Color(0xff252525),
                  ),
                  titleSmall: TextStyle(
                    color: Color(0xff252525),
                  ),
                ),

                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xffF8F8FA),
                  foregroundColor: Color(0xff252525),
                  elevation: 0,
                  centerTitle: true,
                ),
              ),

              // Dark Theme
              darkTheme: ThemeData(
                useMaterial3: true,
                brightness: Brightness.dark,
                fontFamily: 'inter',

                scaffoldBackgroundColor: const Color(0xff121212),
                cardColor: const Color(0xff1E1E1E),

                colorScheme: ColorScheme.fromSeed(
                  seedColor: state.color,
                  brightness: Brightness.dark,
                ),

                textTheme: const TextTheme(
                  bodyLarge: TextStyle(
                    color: Colors.white,
                  ),
                  bodyMedium: TextStyle(
                    color: Colors.white,
                  ),
                  bodySmall: TextStyle(
                    color: Color(0xffBBBBBB),
                  ),
                  titleLarge: TextStyle(
                    color: Colors.white,
                  ),
                  titleMedium: TextStyle(
                    color: Colors.white,
                  ),
                  titleSmall: TextStyle(
                    color: Colors.white,
                  ),
                ),

                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xff121212),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
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
    //return '/focusScreen'; 
  
    return AppRoutes.OnboardingScreen;
  }
}
