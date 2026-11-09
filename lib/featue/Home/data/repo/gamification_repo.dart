import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamificationRepository {
  static const String _key = 'focusflow_gamification';

  final SharedPreferences prefs;

  GamificationRepository(this.prefs);

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

      return GamificationModel.fromJson(
        Map<String, dynamic>.from(decodedData),
      );
    } catch (e) {
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

  String _dateToString(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  Future<GamificationModel> completeTaskReward() async {
    final oldData = getData();

    final today = DateTime.now();

    final todayKey = _dateToString(today);

    final yesterdayKey = _dateToString(
      today.subtract(const Duration(days: 1)),
    );

    final days = List<String>.from(oldData.achievementDays);

    int newStreak = oldData.streak;

    if (!days.contains(todayKey)) {
      if (days.contains(yesterdayKey)) {
        newStreak++;
      } else {
        newStreak = 1;
      }

      days.add(todayKey);
    }

    final newData = GamificationModel(
      xp: oldData.xp + 10,
      streak: newStreak,
      lastCompletedDate: today,
      achievementDays: days,
    );

    await saveData(newData);

    return newData;
  }

  Future<GamificationModel> undoCompletedTask() async {
    final oldData = getData();

    final newXp = oldData.xp >= 10 ? oldData.xp - 10 : 0;

    final newData = oldData.copyWith(
      xp: newXp,
    );

    await saveData(newData);

    return newData;
  }
}
