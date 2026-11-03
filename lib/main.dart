import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_flow/featue/tasks/data/task_repo.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:focus_flow/core/services/local/local_helper.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/Data/repo/task_repo.dart' hide TaskRepository;
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';
import 'package:focus_flow/focusFlowApp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalHelper.init();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(TaskModelAdapter());
  }

  await Hive.openBox<TaskModel>('tasksBox');

 final Box<TaskModel> taskBox =
    Hive.box<TaskModel>('tasksBox');

runApp(
  MultiBlocProvider(
    providers: [
      BlocProvider<TaskCubitCubit>(
        create: (_) => TaskCubitCubit(
          TaskRepository(taskBox) as TaskRepository,
        )..getTasks(),
      ),
    ],
    child: const Focusflowapp(),
  ),
);
}
