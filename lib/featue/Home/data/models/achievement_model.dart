import 'package:flutter/foundation.dart';
import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';

@immutable
class Achievement {
  final String id;
  final String title;
  final String description;
  final String icon;
  final String category;
  final bool Function(GamificationModel data) condition;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
    required this.condition,
  });

  static final List<Achievement> allAchievements = [
    Achievement(
      id: 'first_task',
      title: 'First Step',
      description: 'Completed your first study task',
      icon: '🎯',
      category: 'Tasks',
      condition: (data) => data.tasksCompletedCount >= 1,
    ),
    Achievement(
      id: 'first_focus',
      title: 'Deep Diver',
      description: 'Completed your first focus session',
      icon: '⏱️',
      category: 'Focus',
      condition: (data) => data.focusSessionsCount >= 1,
    ),
    Achievement(
      id: 'streak_3',
      title: 'Momentum Spark',
      description: 'Maintained a 3-day study streak',
      icon: '🔥',
      category: 'Streak',
      condition: (data) => data.streak >= 3 || data.bestStreak >= 3,
    ),
    Achievement(
      id: 'streak_7',
      title: 'Week Warrior',
      description: 'Kept the study streak alive for 7 days',
      icon: '⚡',
      category: 'Streak',
      condition: (data) => data.streak >= 7 || data.bestStreak >= 7,
    ),
    Achievement(
      id: 'tasks_5',
      title: 'Task Crusher',
      description: 'Completed 5 university tasks',
      icon: '🏆',
      category: 'Tasks',
      condition: (data) => data.tasksCompletedCount >= 5,
    ),
    Achievement(
      id: 'level_3',
      title: 'Focus Scholar',
      description: 'Earned enough XP to reach Level 3',
      icon: '🎓',
      category: 'Level',
      condition: (data) => data.level >= 3,
    ),
    Achievement(
      id: 'daily_50',
      title: 'Power Surge',
      description: 'Earned 50+ XP in a single day',
      icon: '🚀',
      category: 'Daily',
      condition: (data) => data.dailyXp >= 50,
    ),
    Achievement(
      id: 'focus_3',
      title: 'Focus Master',
      description: 'Completed 3 deep focus sessions',
      icon: '🧘',
      category: 'Focus',
      condition: (data) => data.focusSessionsCount >= 3,
    ),
  ];
}
