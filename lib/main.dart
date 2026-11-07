import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:focus_flow/core/services/local/local_helper.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/focusFlowApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local storage safely with timeout
  try {
    await LocalHelper.init().timeout(const Duration(seconds: 3));
  } catch (e) {
    debugPrint('LocalHelper.init error: $e');
  }

  // Initialize Hive safely (skip full init on web if needed)
  try {
    await Hive.initFlutter().timeout(const Duration(seconds: 3));

    // Register Task Priority Adapter
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskPriorityAdapter());
    }

    // Register Task Status Adapter
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(TaskStatusAdapter());
    }

    // Register Task Model Adapter
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(TaskModelAdapter());
    }

    // Open Tasks Box safely with timeout
    if (!Hive.isBoxOpen('tasksBox')) {
      try {
        await Hive.openBox<TaskModel>('tasksBox')
            .timeout(const Duration(seconds: 5));
      } catch (e) {
        debugPrint('tasksBox open timeout or error, recovering: $e');
        try {
          if (!kIsWeb) {
            await Hive.deleteBoxFromDisk('tasksBox');
          }
          await Hive.openBox<TaskModel>('tasksBox')
              .timeout(const Duration(seconds: 5));
        } catch (e2) {
          debugPrint('tasksBox recovery failed: $e2');
        }
      }
    }
  } catch (e, stack) {
    debugPrint('Hive initialization error: $e');
    debugPrint(stack.toString());
  }

  // Launch App — MUST be called before FlutterNativeSplash.remove()
  runApp(const Focusflowapp());

  // Dismiss native splash AFTER runApp so the first frame can be drawn
  // The web splash is also removed via the flutter-first-frame event in index.html
  try {
    FlutterNativeSplash.remove();
  } catch (_) {}
}
