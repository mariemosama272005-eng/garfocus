import 'package:flutter/foundation.dart';

@immutable
class GamificationModel {
  final int xp;
  final int dailyXp;
  final String dailyXpDate;
  final int streak;
  final int bestStreak;
  final int tasksCompletedCount;
  final int focusSessionsCount;
  final int totalFocusMinutes;
  final DateTime? lastCompletedDate;
  final List<String> achievementDays;
  final List<String> unlockedAchievementIds;

  const GamificationModel({
    this.xp = 0,
    this.dailyXp = 0,
    this.dailyXpDate = '',
    this.streak = 0,
    this.bestStreak = 0,
    this.tasksCompletedCount = 0,
    this.focusSessionsCount = 0,
    this.totalFocusMinutes = 0,
    this.lastCompletedDate,
    this.achievementDays = const [],
    this.unlockedAchievementIds = const [],
  });

  /// Current level based on total XP (every 100 XP = 1 Level)
  int get level => (xp ~/ 100) + 1;

  /// XP earned inside current level (0..99)
  int get currentLevelXp => xp % 100;

  /// Progress fraction inside current level (0.0 .. 1.0)
  double get progress => (currentLevelXp / 100.0).clamp(0.0, 1.0);

  /// XP needed to reach next level
  int get xpToNextLevel => 100 - currentLevelXp;

  /// Student-friendly title based on level
  String get levelTitle {
    if (level <= 1) return 'Focus Starter';
    if (level == 2) return 'Steady Achiever';
    if (level == 3) return 'Flow Scholar';
    if (level == 4) return 'Deep Worker';
    return 'Master of Focus';
  }

  bool isAchievementUnlocked(String id) =>
      unlockedAchievementIds.contains(id);

  Map<String, dynamic> toJson() {
    return {
      'xp': xp,
      'dailyXp': dailyXp,
      'dailyXpDate': dailyXpDate,
      'streak': streak,
      'bestStreak': bestStreak,
      'tasksCompletedCount': tasksCompletedCount,
      'focusSessionsCount': focusSessionsCount,
      'totalFocusMinutes': totalFocusMinutes,
      'lastCompletedDate': lastCompletedDate?.toIso8601String(),
      'achievementDays': achievementDays,
      'unlockedAchievementIds': unlockedAchievementIds,
    };
  }

  factory GamificationModel.fromJson(Map<String, dynamic> json) {
    final achievementDaysJson = json['achievementDays'];
    final unlockedAchievementsJson = json['unlockedAchievementIds'];

    final parsedXp = json['xp'] is int
        ? json['xp'] as int
        : int.tryParse(json['xp']?.toString() ?? '') ?? 0;

    final parsedStreak = json['streak'] is int
        ? json['streak'] as int
        : int.tryParse(json['streak']?.toString() ?? '') ?? 0;

    final parsedBestStreak = json['bestStreak'] is int
        ? json['bestStreak'] as int
        : int.tryParse(json['bestStreak']?.toString() ?? '') ?? parsedStreak;

    return GamificationModel(
      xp: parsedXp,
      dailyXp: json['dailyXp'] is int
          ? json['dailyXp'] as int
          : int.tryParse(json['dailyXp']?.toString() ?? '') ?? 0,
      dailyXpDate: json['dailyXpDate']?.toString() ?? '',
      streak: parsedStreak,
      bestStreak: parsedBestStreak < parsedStreak ? parsedStreak : parsedBestStreak,
      tasksCompletedCount: json['tasksCompletedCount'] is int
          ? json['tasksCompletedCount'] as int
          : int.tryParse(json['tasksCompletedCount']?.toString() ?? '') ?? 0,
      focusSessionsCount: json['focusSessionsCount'] is int
          ? json['focusSessionsCount'] as int
          : int.tryParse(json['focusSessionsCount']?.toString() ?? '') ?? 0,
      totalFocusMinutes: json['totalFocusMinutes'] is int
          ? json['totalFocusMinutes'] as int
          : int.tryParse(json['totalFocusMinutes']?.toString() ?? '') ?? 0,
      lastCompletedDate: json['lastCompletedDate'] != null
          ? DateTime.tryParse(json['lastCompletedDate'].toString())
          : null,
      achievementDays: achievementDaysJson is List
          ? achievementDaysJson.map((e) => e.toString()).toList()
          : const [],
      unlockedAchievementIds: unlockedAchievementsJson is List
          ? unlockedAchievementsJson.map((e) => e.toString()).toList()
          : const [],
    );
  }

  GamificationModel copyWith({
    int? xp,
    int? dailyXp,
    String? dailyXpDate,
    int? streak,
    int? bestStreak,
    int? tasksCompletedCount,
    int? focusSessionsCount,
    int? totalFocusMinutes,
    DateTime? lastCompletedDate,
    List<String>? achievementDays,
    List<String>? unlockedAchievementIds,
  }) {
    return GamificationModel(
      xp: xp ?? this.xp,
      dailyXp: dailyXp ?? this.dailyXp,
      dailyXpDate: dailyXpDate ?? this.dailyXpDate,
      streak: streak ?? this.streak,
      bestStreak: bestStreak ?? this.bestStreak,
      tasksCompletedCount: tasksCompletedCount ?? this.tasksCompletedCount,
      focusSessionsCount: focusSessionsCount ?? this.focusSessionsCount,
      totalFocusMinutes: totalFocusMinutes ?? this.totalFocusMinutes,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
      achievementDays: achievementDays ?? this.achievementDays,
      unlockedAchievementIds:
          unlockedAchievementIds ?? this.unlockedAchievementIds,
    );
  }
}
