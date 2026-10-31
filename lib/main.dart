
import 'package:flutter/material.dart';
import 'package:focus_flow/focusFlowApp.dart';
void main() {
  runApp(const Focusflowapp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focus Flow',
      theme: ThemeData(
      
      ),
    );
  }
}


