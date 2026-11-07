
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:focus_flow/featue/Home/presntation/cubit/cubit/gamification_cubit.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/Data/repo/task_repo.dart';

part 'task_cubit_state.dart';

class TaskCubitCubit extends Cubit<TaskCubitState> {
  final TaskRepository repository;
  final GamificationCubit gamificationCubit;

  TaskCubitCubit(
    this.repository,
    this.gamificationCubit,
  ) : super(TaskCubitInitial());

  // Get All Tasks
  void getTasks() {
    try {
      print('========== GET TASKS ==========');

      final tasks = repository.getAllTasks();

      print('Tasks Count: ${tasks.length}');

      emit(TaskCubitLoaded(tasks));
    } catch (e, stackTrace) {
      print('GET TASKS ERROR: $e');
      print(stackTrace);

      emit(TaskCubitError(e.toString()));
    }
  }

  // Add Task
  Future<bool> addTask(TaskModel task) async {
    try {
      print('========== START ADD TASK ==========');

      // Check Hive Box
      print(
        'Box Opened: ${Hive.isBoxOpen('tasksBox')}',
      );

      print('Task Title: ${task.title}');
      print('Task Category: ${task.category}');
      print('Task Priority: ${task.priority}');

      // Save Task
      await repository.addTask(task);

      print('========== TASK SAVED SUCCESSFULLY ==========');

      // Check Saved Tasks
      final tasks = repository.getAllTasks();

      print('Tasks Count: ${tasks.length}');

      if (tasks.isNotEmpty) {
        print('Last Task: ${tasks.last.title}');
      }

      // Update UI
      emit(TaskCubitLoaded(tasks));

      return true;

    } catch (e, stackTrace) {
      print('========== SAVE ERROR ==========');
      print('ACTUAL SAVE ERROR: $e');
      print('STACK TRACE:');
      print(stackTrace);

      emit(TaskCubitError(e.toString()));

      return false;
    }
  }

  // Update Task
  Future<bool> updateTask(TaskModel task) async {
    try {
      await repository.updateTask(task);

      getTasks();

      return true;
    } catch (e, stackTrace) {
      print('UPDATE TASK ERROR: $e');
      print(stackTrace);

      emit(TaskCubitError(e.toString()));

      return false;
    }
  }

  // Complete Task
  Future<bool> completeTask(TaskModel task) async {
    try {
      if (task.isCompleted) {
        task.status = TaskStatus.pending;
        task.completedAt = null;
        task.rewardClaimed = false;

        await gamificationCubit.undoCompletedTask();

      } else {
        task.completeTask();

        if (!task.rewardClaimed) {
          task.rewardClaimed = true;

          await gamificationCubit.rewardCompletedTask();
        }
      }

      await repository.updateTask(task);

      final updatedTasks = repository.getAllTasks();

      emit(TaskCubitLoaded(updatedTasks));

      return true;

    } catch (e, stackTrace) {
      print('COMPLETE TASK ERROR: $e');
      print(stackTrace);

      emit(TaskCubitError(e.toString()));

      return false;
    }
  }

  // Delete Task
  Future<bool> deleteTask(TaskModel task) async {
    try {
      await repository.deleteTask(task);

      getTasks();

      return true;

    } catch (e, stackTrace) {
      print('DELETE TASK ERROR: $e');
      print(stackTrace);

      emit(TaskCubitError(e.toString()));

      return false;
    }
  }
}
