import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/presentation/cubit/cubit/task_cubit_cubit.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final TaskCubitCubit taskCubit;
  final TaskModel? oldTask;

  AddTaskCubit(this.taskCubit, this.oldTask) : super(AddTaskInitial()) {
    _initializeData();
  }

  String category = 'Personal';
  TaskPriority priority = TaskPriority.medium;

  DateTime? deadlineDate;
  TimeOfDay? deadlineTime;

  
  void _initializeData() {
    if (oldTask != null) {
      category = oldTask!.category;
      priority = oldTask!.priority;
      deadlineDate = oldTask!.deadlineDate;

      if (oldTask!.deadlineMinutes != null) {
        final minutes = oldTask!.deadlineMinutes!;
        deadlineTime = TimeOfDay(
          hour: minutes ~/ 60,
          minute: minutes % 60,
        );
      }
    }
  }

  void setCategory(String value) {
    category = value;
    emit(AddTaskUpdated());
  }

  void setPriority(TaskPriority value) {
    priority = value;
    emit(AddTaskUpdated());
  }

  void setDeadline(DateTime date, TimeOfDay time) {
    deadlineDate = date;
    deadlineTime = time;
    emit(AddTaskUpdated());
  }

  Future<bool> saveTask({
    required String title,
    required String details,
  }) async {
    if (title.trim().isEmpty) {
      return false;
    }

    int? deadlineMinutes;
    if (deadlineTime != null) {
      deadlineMinutes = deadlineTime!.hour * 60 + deadlineTime!.minute;
    }

    try {
      // إذا كانت مهمة قديمة، نقوم بتحديث بياناتها، وإلا ننشئ مهمة جديدة
      final task = oldTask ??
          TaskModel(
            title: title.trim(),
            details: details.trim(),
            category: category,
            priority: priority,
          );

      task
        ..title = title.trim()
        ..details = details.trim()
        ..category = category
        ..priority = priority
        ..deadlineDate = deadlineDate
        ..deadlineMinutes = deadlineMinutes;

      bool result = false;
      if (oldTask == null) {
        debugPrint('Calling taskCubit.addTask...');
        result = await taskCubit.addTask(task);
        debugPrint('addTask result: $result');
      } else {
        debugPrint('Calling taskCubit.updateTask...');
        result = await taskCubit.updateTask(task);
        debugPrint('updateTask result: $result');
      }

      return result;
    } catch (e, stackTrace) {
      debugPrint('CRITICAL ERROR in saveTask: $e');
      debugPrint(stackTrace.toString());
      return false;
    }
  }
}