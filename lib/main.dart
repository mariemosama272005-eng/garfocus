import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:focus_flow/core/services/local/local_helper.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/Data/repo/task_repo.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

import 'package:focus_flow/featue/Home/data/repo/gamification_repo.dart';
import 'package:focus_flow/featue/Home/presntation/cubit/cubit/gamification_cubit.dart';

import 'package:focus_flow/focusFlowApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize SharedPreferences
  await LocalHelper.init();

  // Initialize Hive
  await Hive.initFlutter();

  // Register TaskModel adapter
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(TaskModelAdapter());
  }

  // Open Tasks Box
  final taskBox = await Hive.openBox<TaskModel>('tasksBox');

  // Create repositories
  final taskRepository = TaskRepository(taskBox);

  final gamificationRepository = GamificationRepository(
    LocalHelper.prefs!,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        // Gamification
        BlocProvider<GamificationCubit>(
          create: (_) => GamificationCubit(
            gamificationRepository,
          ),
        ),

        // Tasks
        BlocProvider<TaskCubitCubit>(
          create: (context) => TaskCubitCubit(
            taskRepository,
            context.read<GamificationCubit>(),
          )..getTasks(),
        ),
      ],
      child: const Focusflowapp(),
    ),
  );
}