part of 'task_cubit_cubit.dart';

@immutable
sealed class TaskCubitState {}

final class TaskCubitInitial extends TaskCubitState {}

final class TaskCubitLoading extends TaskCubitState {}

final class TaskCubitLoaded extends TaskCubitState {
  final List<TaskModel> tasks;

  TaskCubitLoaded(this.tasks);
}

final class TaskCubitError extends TaskCubitState {
  final String message;

  TaskCubitError(this.message);
}