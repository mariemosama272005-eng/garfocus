import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class TaskModel extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String details;

  @HiveField(2)
  String category;

  @HiveField(3)
  DateTime? deadlineDate;

  @HiveField(4)
  int? deadlineMinutes;

  @HiveField(5)
  String priority;

  @HiveField(6)
  String status;

  TaskModel({
    required this.title,
    required this.details,
    required this.category,
    this.deadlineDate,
    this.deadlineMinutes,
    required this.priority,
    this.status = 'pending',
  });
}