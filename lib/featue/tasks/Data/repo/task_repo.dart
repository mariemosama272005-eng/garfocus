import 'package:focus_flow/featue/tasks/Data/models/task_model.dart';
import 'package:hive/hive.dart';


class TaskRepository {
  final Box<TaskModel> _taskBox;

  TaskRepository(this._taskBox);

  Future<void> addTask(TaskModel task) async {
    await _taskBox.add(task);
  }

  List<TaskModel> getAllTasks() {
    return _taskBox.values.toList();
  }

 
  List<TaskModel> getCompletedTasks() {
    return _taskBox.values.where((task) => task.isCompleted).toList();
  }


  List<TaskModel> getUnclaimedRewardTasks() {
    return _taskBox.values
        .where((task) => task.isCompleted && !task.rewardClaimed)
        .toList();
  }

  Future<void> updateTask(TaskModel task) async {
    await task.save();
  }

  Future<void> deleteTask(TaskModel task) async {
    await task.delete();
  }
}