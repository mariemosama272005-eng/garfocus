import 'package:flutter_test/flutter_test.dart';
import 'package:focus_flow/featue/Home/data/models/achievement_model.dart';
import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';
import 'package:focus_flow/featue/Home/data/repo/gamification_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GamificationModel Calculations', () {
    test('Calculates level and progress correctly from total XP', () {
      const modelZero = GamificationModel(xp: 0);
      expect(modelZero.level, 1);
      expect(modelZero.currentLevelXp, 0);
      expect(modelZero.progress, 0.0);
      expect(modelZero.xpToNextLevel, 100);

      const model45 = GamificationModel(xp: 45);
      expect(model45.level, 1);
      expect(model45.currentLevelXp, 45);
      expect(model45.progress, 0.45);
      expect(model45.xpToNextLevel, 55);

      const model100 = GamificationModel(xp: 100);
      expect(model100.level, 2);
      expect(model100.currentLevelXp, 0);
      expect(model100.progress, 0.0);

      const model280 = GamificationModel(xp: 280);
      expect(model280.level, 3);
      expect(model280.currentLevelXp, 80);
      expect(model280.progress, 0.8);
      expect(model280.xpToNextLevel, 20);
    });

    test('Serializes and deserializes JSON cleanly with all fields', () {
      final now = DateTime.now();
      final model = GamificationModel(
        xp: 150,
        dailyXp: 35,
        dailyXpDate: '2026-11-09',
        streak: 3,
        bestStreak: 5,
        tasksCompletedCount: 4,
        focusSessionsCount: 2,
        totalFocusMinutes: 50,
        lastCompletedDate: now,
        achievementDays: const ['2026-11-07', '2026-11-08', '2026-11-09'],
        unlockedAchievementIds: const ['first_task', 'first_focus'],
      );

      final json = model.toJson();
      final decoded = GamificationModel.fromJson(json);

      expect(decoded.xp, 150);
      expect(decoded.dailyXp, 35);
      expect(decoded.streak, 3);
      expect(decoded.bestStreak, 5);
      expect(decoded.tasksCompletedCount, 4);
      expect(decoded.focusSessionsCount, 2);
      expect(decoded.totalFocusMinutes, 50);
      expect(decoded.achievementDays.length, 3);
      expect(decoded.unlockedAchievementIds.length, 2);
      expect(decoded.isAchievementUnlocked('first_task'), isTrue);
      expect(decoded.isAchievementUnlocked('streak_7'), isFalse);
    });
  });

  group('GamificationRepository Logic', () {
    late SharedPreferences prefs;
    late GamificationRepository repo;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
      repo = GamificationRepository(prefs);
    });

    test('Awarding task completion adds +10 XP, updates streak, unlocks first_task badge', () async {
      final result = await repo.completeTaskReward();

      expect(result.xp, 10);
      expect(result.dailyXp, 10);
      expect(result.tasksCompletedCount, 1);
      expect(result.streak, 1);
      expect(result.bestStreak, 1);
      expect(result.isAchievementUnlocked('first_task'), isTrue);

      // Verify persisted in SharedPreferences
      final reloaded = repo.getData();
      expect(reloaded.xp, 10);
      expect(reloaded.dailyXp, 10);
      expect(reloaded.isAchievementUnlocked('first_task'), isTrue);
    });

    test('Completing a focus session adds +15 XP, records minutes, unlocks first_focus badge', () async {
      final result = await repo.rewardCompletedFocusSession(minutes: 25);

      expect(result.xp, 15);
      expect(result.dailyXp, 15);
      expect(result.focusSessionsCount, 1);
      expect(result.totalFocusMinutes, 25);
      expect(result.streak, 1);
      expect(result.isAchievementUnlocked('first_focus'), isTrue);
    });

    test('Undo task removes 10 XP and decrements task count', () async {
      await repo.completeTaskReward();
      await repo.completeTaskReward(); // total 20 XP

      var current = repo.getData();
      expect(current.xp, 20);
      expect(current.tasksCompletedCount, 2);

      final undone = await repo.undoCompletedTask();
      expect(undone.xp, 10);
      expect(undone.tasksCompletedCount, 1);
    });

    test('Unlocks multi-task and streak achievements on real criteria', () async {
      // Complete 5 tasks
      for (int i = 0; i < 5; i++) {
        await repo.completeTaskReward();
      }

      final data = repo.getData();
      expect(data.tasksCompletedCount, 5);
      expect(data.isAchievementUnlocked('first_task'), isTrue);
      expect(data.isAchievementUnlocked('tasks_5'), isTrue);
    });
  });
}
