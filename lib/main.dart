
import 'package:flutter/material.dart';
import 'package:focus_flow/core/services/local/local_helper.dart';
import 'package:focus_flow/focusFlowApp.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalHelper.init();

  runApp(const Focusflowapp());
}


