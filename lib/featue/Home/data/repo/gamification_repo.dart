import 'dart:convert';

import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamificationRepository {
  static const String _key = 'focusflow_gamification';

  final SharedPreferences prefs;

  GamificationRepository(this.prefs);

  GamificationModel getData() {
    final savedData = prefs.getString(_key);

    if (savedData == null) {
      return GamificationModel();
    }

    return GamificationModel.fromJson(
      jsonDecode(savedData) as Map<String, dynamic>,
    );
  }

  Future<void> saveData(
    GamificationModel data,
  ) async {
    await prefs.setString(
      _key,
      jsonEncode(data.toJson()),
    );
  }

  // Complete task = +10 XP
  Future<GamificationModel> completeTaskReward() async {
    final oldData = getData();

    final today = DateTime.now();

    final todayKey =
        '${today.year}-${today.month}-${today.day}';

    final yesterday =
        today.subtract(
      const Duration(days: 1),
    );

    final yesterdayKey =
        '${yesterday.year}-${yesterday.month}-${yesterday.day}';

    final days =
        List<String>.from(
      oldData.achievementDays,
    );

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

  // Uncomplete task = -10 XP
  Future<GamificationModel> undoCompletedTask() async {
    final oldData = getData();

    final newXp = oldData.xp >= 10
        ? oldData.xp - 10
        : 0;

    final newData = GamificationModel(
      xp: newXp,
      streak: oldData.streak,
      lastCompletedDate:
          oldData.lastCompletedDate,
      achievementDays:
          oldData.achievementDays,
    );

    await saveData(newData);

    return newData;
  }
}