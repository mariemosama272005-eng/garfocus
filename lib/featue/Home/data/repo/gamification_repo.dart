import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focus_flow/featue/Home/data/models/achievement_model.dart';
import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamificationRepository {
  static const String _key = 'focusflow_gamification';

  final SharedPreferences prefs;

  GamificationRepository(this.prefs);

  String _dateToString(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  /// Load and normalize current Gamification data
  GamificationModel getData() {
    try {
      final savedData = prefs.getString(_key);

      if (savedData == null || savedData.isEmpty) {
        return const GamificationModel();
      }

      final decodedData = jsonDecode(savedData);

      if (decodedData is! Map) {
        return const GamificationModel();
      }

      var model = GamificationModel.fromJson(
        Map<String, dynamic>.from(decodedData),
      );

      final now = DateTime.now();
      final todayKey = _dateToString(now);
      final yesterdayKey = _dateToString(now.subtract(const Duration(days: 1)));

      // Normalize Daily XP (resets if the day has changed)
      int normalizedDailyXp = model.dailyXp;
      String normalizedDailyDate = model.dailyXpDate;
      if (normalizedDailyDate.isEmpty || normalizedDailyDate != todayKey) {
        normalizedDailyXp = 0;
        normalizedDailyDate = todayKey;
      }

      // Check if streak was broken (missed yesterday and today has not started yet)
      int normalizedStreak = model.streak;
      if (model.lastCompletedDate != null) {
        final lastKey = _dateToString(model.lastCompletedDate!);
        if (lastKey != todayKey && lastKey != yesterdayKey) {
          normalizedStreak = 0;
        }
      }

      // Check if any achievements should already be unlocked
      final unlocked = _evaluateAchievements(model);

      final normalizedModel = model.copyWith(
        dailyXp: normalizedDailyXp,
        dailyXpDate: normalizedDailyDate,
        streak: normalizedStreak,
        bestStreak: max(model.bestStreak, normalizedStreak),
        unlockedAchievementIds: unlocked,
      );

      return normalizedModel;
    } catch (e) {
      debugPrint('Gamification getData error: $e');
      return const GamificationModel();
    }
  }

  Future<void> saveData(GamificationModel data) async {
    try {
      final jsonString = jsonEncode(data.toJson());
      await prefs.setString(_key, jsonString);
    } catch (e) {
      debugPrint('Gamification save error: $e');
    }
  }

  /// Award XP and update streak/achievements for completing a task (+10 XP)
  Future<GamificationModel> completeTaskReward() async {
    final current = getData();
    final today = DateTime.now();
    final todayKey = _dateToString(today);
    final yesterdayKey = _dateToString(today.subtract(const Duration(days: 1)));

    final days = List<String>.from(current.achievementDays);
    int newStreak = current.streak;

    if (!days.contains(todayKey)) {
      if (days.contains(yesterdayKey) ||
          (current.lastCompletedDate != null &&
              _dateToString(current.lastCompletedDate!) == yesterdayKey)) {
        newStreak++;
      } else {
        newStreak = 1;
      }
      days.add(todayKey);
    } else if (newStreak == 0) {
      newStreak = 1;
    }

    final newBestStreak = max(current.bestStreak, newStreak);

    // Calculate Daily XP
    final isSameDay = current.dailyXpDate == todayKey;
    final newDailyXp = (isSameDay ? current.dailyXp : 0) + 10;

    var updated = current.copyWith(
      xp: current.xp + 10,
      dailyXp: newDailyXp,
      dailyXpDate: todayKey,
      streak: newStreak,
      bestStreak: newBestStreak,
      tasksCompletedCount: current.tasksCompletedCount + 1,
      lastCompletedDate: today,
      achievementDays: days,
    );

    // Check achievements
    final unlocked = _evaluateAchievements(updated);
    updated = updated.copyWith(unlockedAchievementIds: unlocked);

    await saveData(updated);
    return updated;
  }

  /// Revert XP when a task is toggled back to pending (-10 XP)
  Future<GamificationModel> undoCompletedTask() async {
    final current = getData();
    final today = DateTime.now();
    final todayKey = _dateToString(today);

    final newXp = current.xp >= 10 ? current.xp - 10 : 0;
    final isSameDay = current.dailyXpDate == todayKey;
    final newDailyXp = isSameDay && current.dailyXp >= 10
        ? current.dailyXp - 10
        : 0;

    final newTasksCount = current.tasksCompletedCount > 0
        ? current.tasksCompletedCount - 1
        : 0;

    final updated = current.copyWith(
      xp: newXp,
      dailyXp: newDailyXp,
      tasksCompletedCount: newTasksCount,
    );

    await saveData(updated);
    return updated;
  }

  /// Award XP and update streak/achievements for completing a focus session (+15 XP)
  Future<GamificationModel> rewardCompletedFocusSession({
    int minutes = 25,
  }) async {
    final current = getData();
    final today = DateTime.now();
    final todayKey = _dateToString(today);
    final yesterdayKey = _dateToString(today.subtract(const Duration(days: 1)));

    final days = List<String>.from(current.achievementDays);
    int newStreak = current.streak;

    if (!days.contains(todayKey)) {
      if (days.contains(yesterdayKey) ||
          (current.lastCompletedDate != null &&
              _dateToString(current.lastCompletedDate!) == yesterdayKey)) {
        newStreak++;
      } else {
        newStreak = 1;
      }
      days.add(todayKey);
    } else if (newStreak == 0) {
      newStreak = 1;
    }

    final newBestStreak = max(current.bestStreak, newStreak);

    // Calculate Daily XP
    final isSameDay = current.dailyXpDate == todayKey;
    const focusXpReward = 15;
    final newDailyXp = (isSameDay ? current.dailyXp : 0) + focusXpReward;

    var updated = current.copyWith(
      xp: current.xp + focusXpReward,
      dailyXp: newDailyXp,
      dailyXpDate: todayKey,
      streak: newStreak,
      bestStreak: newBestStreak,
      focusSessionsCount: current.focusSessionsCount + 1,
      totalFocusMinutes: current.totalFocusMinutes + minutes,
      lastCompletedDate: today,
      achievementDays: days,
    );

    // Check achievements
    final unlocked = _evaluateAchievements(updated);
    updated = updated.copyWith(unlockedAchievementIds: unlocked);

    await saveData(updated);
    return updated;
  }

  List<String> _evaluateAchievements(GamificationModel data) {
    final list = List<String>.from(data.unlockedAchievementIds);
    for (final achievement in Achievement.allAchievements) {
      if (!list.contains(achievement.id) && achievement.condition(data)) {
        list.add(achievement.id);
      }
    }
    return list;
  }
}
