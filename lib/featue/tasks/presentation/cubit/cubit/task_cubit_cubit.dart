import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:focus_flow/featue/Home/presntation/cubit/cubit/gamification_cubit.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:focus_flow/featue/tasks/Data/repo/task_repo.dart';

part 'task_cubit_state.dart';

class TaskCubitCubit
    extends Cubit<TaskCubitState> {
  final TaskRepository repository;
  final GamificationCubit gamificationCubit;

  TaskCubitCubit(
    this.repository,
    this.gamificationCubit,
  ) : super(TaskCubitInitial());

  // =========================
  // GET TASKS
  // =========================

  void getTasks() {
    try {
      final tasks = repository.getTasks();

      emit(TaskCubitLoaded(tasks));
    } catch (e) {
      emit(
        TaskCubitError(e.toString()),
      );
    }
  }

  // =========================
  // ADD TASK
  // =========================

  Future<bool> addTask(
    TaskModel task,
  ) async {
    try {
      await repository.addTask(task);

      getTasks();

      return true;
    } catch (e) {
      emit(
        TaskCubitError(e.toString()),
      );

      return false;
    }
  }

  // =========================
  // UPDATE TASK
  // =========================

  Future<bool> updateTask(
    TaskModel task,
  ) async {
    try {
      await repository.updateTask(task);

      getTasks();

      return true;
    } catch (e) {
      emit(
        TaskCubitError(e.toString()),
      );

      return false;
    }
  }

  // =========================
  // COMPLETE / UNDO
  // =========================

  Future<bool> completeTask(
    TaskModel task,
  ) async {
    try {
      final isCompleted =
          task.status.trim().toLowerCase() ==
              'completed';

      // =========================
      // COMPLETED -> PENDING
      // =========================

      if (isCompleted) {
        task.status = 'pending';
        task.completedAt = null;

        // Allow reward again
        task.rewardClaimed = false;

        // Remove 10 XP
        await gamificationCubit
            .undoCompletedTask();
      }

      // =========================
      // PENDING -> COMPLETED
      // =========================

      else {
        task.status = 'completed';
        task.completedAt = DateTime.now();

        // Give reward only once
        if (!task.rewardClaimed) {
          task.rewardClaimed = true;

          // Add 10 XP
          await gamificationCubit
              .rewardCompletedTask();
        }
      }

      // =========================
      // SAVE TASK
      // =========================

      await repository.updateTask(task);

      // =========================
      // REFRESH TASK LIST
      // =========================

      final updatedTasks =
          repository.getTasks();

      emit(
        TaskCubitLoaded(updatedTasks),
      );

      return true;
    } catch (e) {
      emit(
        TaskCubitError(e.toString()),
      );

      return false;
    }
  }

  // =========================
  // DELETE
  // =========================

  Future<bool> deleteTask(
    TaskModel task,
  ) async {
    try {
      await repository.deleteTask(task);

      getTasks();

      return true;
    } catch (e) {
      emit(
        TaskCubitError(e.toString()),
      );

      return false;
    }
  }
}