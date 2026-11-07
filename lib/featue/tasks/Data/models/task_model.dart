import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
enum TaskPriority {
  @HiveField(0)
  low,
  @HiveField(1)
  medium,
  @HiveField(2)
  high,
}

@HiveType(typeId: 2)
enum TaskStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  inProgress,
  @HiveField(2)
  completed,
}

@HiveType(typeId: 3)
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
  TaskPriority priority;

  @HiveField(6)
  TaskStatus status;

  @HiveField(7)
  bool rewardClaimed;

  @HiveField(8)
  DateTime? completedAt;

  TaskModel({
    required this.title,
    required this.details,
    required this.category,
    this.deadlineDate,
    this.deadlineMinutes,
    required this.priority,
    this.status = TaskStatus.pending,
    this.rewardClaimed = false,
    this.completedAt,
  });

 
  bool get isCompleted => status == TaskStatus.completed;

  void completeTask() {
    status = TaskStatus.completed;
    completedAt = DateTime.now();
  }

  void claimReward() {
    if (isCompleted && !rewardClaimed) {
      rewardClaimed = true;
      save(); 
    }
  }
}