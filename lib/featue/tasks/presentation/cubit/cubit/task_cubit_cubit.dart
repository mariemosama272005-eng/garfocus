
import 'package:bloc/bloc.dart';
import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:meta/meta.dart';

import '../../../data/models/task_model.dart' hide TaskModel;
import '../../../data/task_repo.dart';

part 'task_cubit_state.dart';

class TaskCubitCubit extends Cubit<TaskCubitState> {
  final TaskRepository repository;

  TaskCubitCubit(this.repository) : super(TaskCubitInitial());

  void getTasks() {
    try {
      emit(TaskCubitLoading());

      final tasks = repository.getTasks();

      emit(TaskCubitLoaded(tasks.cast<TaskModel>()));
    } catch (e) {
      emit(TaskCubitError(e.toString()));
    }
  }

  Future<void> addTask(TaskModel task) async {
    try {
      await repository.addTask(task);

      getTasks();
    } catch (e) {
      emit(TaskCubitError(e.toString()));
    }
  }

  Future<void> completeTask(TaskModel task) async {
    try {
      if (task.status == 'completed') {
        task.status = 'pending';
      } else {
        task.status = 'completed';
      }

      await repository.updateTask(task);

      getTasks();
    } catch (e) {
      emit(TaskCubitError(e.toString()));
    }
  }

  Future<void> deleteTask(TaskModel task) async {
    try {
      await repository.deleteTask(task as TaskModel);

      getTasks();
    } catch (e) {
      emit(TaskCubitError(e.toString()));
    }
  }
}
