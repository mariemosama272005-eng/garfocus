
import 'package:flutter/foundation.dart';

@immutable
class GamificationModel {
  final int xp;
  final int streak;
  final DateTime? lastCompletedDate;
  final List<String> achievementDays;

  const GamificationModel({
    this.xp = 0,
    this.streak = 0,
    this.lastCompletedDate,
    this.achievementDays = const [],
  });

  int get level => (xp ~/ 100) + 1;

  int get currentLevelXp => xp % 100;

  double get progress => currentLevelXp / 100;

  Map<String, dynamic> toJson() {
    return {
      'xp': xp,
      'streak': streak,
      'lastCompletedDate': lastCompletedDate?.toIso8601String(),
      'achievementDays': achievementDays,
    };
  }

  factory GamificationModel.fromJson(Map<String, dynamic> json) {
    final achievementDaysJson = json['achievementDays'];

    return GamificationModel(
      xp: json['xp'] is int
          ? json['xp'] as int
          : int.tryParse(json['xp']?.toString() ?? '') ?? 0,

      streak: json['streak'] is int
          ? json['streak'] as int
          : int.tryParse(json['streak']?.toString() ?? '') ?? 0,

      lastCompletedDate: json['lastCompletedDate'] != null
          ? DateTime.tryParse(
              json['lastCompletedDate'].toString(),
            )
          : null,

      achievementDays: achievementDaysJson is List
          ? achievementDaysJson.map((e) => e.toString()).toList()
          : const [],
    );
  }

  GamificationModel copyWith({
    int? xp,
    int? streak,
    DateTime? lastCompletedDate,
    List<String>? achievementDays,
  }) {
    return GamificationModel(
      xp: xp ?? this.xp,
      streak: streak ?? this.streak,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
      achievementDays: achievementDays ?? this.achievementDays,
    );
  }
}

