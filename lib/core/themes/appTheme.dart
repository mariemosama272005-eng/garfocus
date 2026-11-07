import 'package:flutter/material.dart';

class AppTheme {

  static ThemeData lightTheme(Color seedColor) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'inter',
      scaffoldBackgroundColor: const Color(0xffF8F8FA),
      cardColor: Colors.white,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color(0xff252525)),
        bodyMedium: TextStyle(color: Color(0xff252525)),
        bodySmall: TextStyle(color: Color(0xff666666)),
        titleLarge: TextStyle(color: Color(0xff252525)),
        titleMedium: TextStyle(color: Color(0xff252525)),
        titleSmall: TextStyle(color: Color(0xff252525)),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xffF8F8FA),
        foregroundColor: Color(0xff252525),
        elevation: 0,
        centerTitle: true,
      ),
    );
  }


  static ThemeData darkTheme(Color seedColor) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: 'inter',
      scaffoldBackgroundColor: const Color(0xff121212),
      cardColor: const Color(0xff1E1E1E),
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: Brightness.dark,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Color(0xffBBBBBB)),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff121212),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
    );
  }
}