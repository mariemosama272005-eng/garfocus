import 'package:hive/hive.dart';

import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';

class TaskRepository {
  final Box<TaskModel> taskBox;

  TaskRepository(this.taskBox);

  Future<void> addTask(TaskModel task) async {
    await taskBox.add(task);
  }

  List<TaskModel> getTasks() {
    return taskBox.values.toList();
  }

  Future<void> updateTask(TaskModel task) async {
    await task.save();
  }

  Future<void> deleteTask(TaskModel task) async {
    await task.delete();
  }
}