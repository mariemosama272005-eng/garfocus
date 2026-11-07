
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:focus_flow/core/services/local/local_helper.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/focusFlowApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

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

  // Initialize local storage
  await LocalHelper.init();

  // Open Tasks Box
  if (!Hive.isBoxOpen('tasksBox')) {
    await Hive.openBox<TaskModel>('tasksBox');
  }

  runApp(const Focusflowapp());
}
