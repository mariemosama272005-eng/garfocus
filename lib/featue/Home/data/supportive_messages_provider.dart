import 'package:focus_flow/featue/Home/data/models/gamification_model.dart';

enum BuddyMood {
  ready,
  momentum,
  smallWin,
  recovering,
  celebrating,
}

class BuddyMessageInfo {
  final String message;
  final String tag;
  final String moodEmoji;
  final BuddyMood mood;

  const BuddyMessageInfo({
    required this.message,
    required this.tag,
    required this.moodEmoji,
    required this.mood,
  });
}

class SupportiveMessagesProvider {
  /// Generate a context-aware message based on current progress
  static List<BuddyMessageInfo> getMessagesForContext({
    required GamificationModel gamification,
    required int completedTasksToday,
    required int totalTasksToday,
    required int highPriorityCount,
  }) {
    // 1. Recovering after falling behind
    if (gamification.streak == 0 && gamification.bestStreak > 0) {
      return const [
        BuddyMessageInfo(
          message: "No shame in pauses. Fresh start right now! 🌱",
          tag: "Fresh Start",
          moodEmoji: "🌱",
          mood: BuddyMood.recovering,
        ),
        BuddyMessageInfo(
          message: "Falling behind is normal. Let's do just 5 minutes today.",
          tag: "Low Pressure",
          moodEmoji: "🌿",
          mood: BuddyMood.recovering,
        ),
        BuddyMessageInfo(
          message: "Reset time. The next 5 minutes count the most.",
          tag: "Gentle Reset",
          moodEmoji: "✨",
          mood: BuddyMood.recovering,
        ),
        BuddyMessageInfo(
          message: "No pressure. Even a 2-minute start breaks the freeze.",
          tag: "Ease In",
          moodEmoji: "💙",
          mood: BuddyMood.recovering,
        ),
      ];
    }

    // 2. All caught up
    if (totalTasksToday > 0 && completedTasksToday == totalTasksToday) {
      return const [
        BuddyMessageInfo(
          message: "All caught up for today! You crushed it! 🎉",
          tag: "Goal Achieved",
          moodEmoji: "🏆",
          mood: BuddyMood.celebrating,
        ),
        BuddyMessageInfo(
          message: "Deck cleared! Time to rest and recharge your brain ✨",
          tag: "Well Deserved",
          moodEmoji: "✨",
          mood: BuddyMood.celebrating,
        ),
        BuddyMessageInfo(
          message: "Look at that progress bar: 100%! You're unstoppable.",
          tag: "Peak Focus",
          moodEmoji: "🚀",
          mood: BuddyMood.celebrating,
        ),
      ];
    }

    // 3. Momentum (2+ tasks done or high streak or 20+ XP today)
    if (completedTasksToday >= 2 ||
        gamification.dailyXp >= 25 ||
        gamification.streak >= 3) {
      return [
        const BuddyMessageInfo(
          message: "Nice! You're building momentum 🔥",
          tag: "In The Flow",
          moodEmoji: "🔥",
          mood: BuddyMood.momentum,
        ),
        const BuddyMessageInfo(
          message: "Flow state unlocked! Keep riding the wave 🌊",
          tag: "Deep Flow",
          moodEmoji: "⚡",
          mood: BuddyMood.momentum,
        ),
        BuddyMessageInfo(
          message: gamification.streak >= 3
              ? "${gamification.streak}-day streak! Consistency looks great on you ⚡"
              : "Look at you go! Stay hydrated and keep steady 💧",
          tag: "Consistency",
          moodEmoji: "💪",
          mood: BuddyMood.momentum,
        ),
        const BuddyMessageInfo(
          message: "Building real habits. One session at a time!",
          tag: "Growth",
          moodEmoji: "🎯",
          mood: BuddyMood.momentum,
        ),
      ];
    }

    // 4. Small wins (1 task done)
    if (completedTasksToday == 1) {
      return const [
        BuddyMessageInfo(
          message: "Tiny progress is still progress! ⭐",
          tag: "Small Win",
          moodEmoji: "⭐",
          mood: BuddyMood.smallWin,
        ),
        BuddyMessageInfo(
          message: "First win in the books! Feel that relief 👏",
          tag: "Friction Broken",
          moodEmoji: "🎉",
          mood: BuddyMood.smallWin,
        ),
        BuddyMessageInfo(
          message: "1 task down! The hardest part is behind you.",
          tag: "Rolling Forward",
          moodEmoji: "🚀",
          mood: BuddyMood.smallWin,
        ),
      ];
    }

    // 5. High Priority waiting
    if (highPriorityCount > 0) {
      return const [
        BuddyMessageInfo(
          message: "One task. That's all we need right now.",
          tag: "Single Focus",
          moodEmoji: "🎯",
          mood: BuddyMood.ready,
        ),
        BuddyMessageInfo(
          message: "You've got this. Just start with 5 minutes.",
          tag: "Quick Start",
          moodEmoji: "⏱️",
          mood: BuddyMood.ready,
        ),
        BuddyMessageInfo(
          message: "Okay, let's make this easy. One step! 🚀",
          tag: "Action Mode",
          moodEmoji: "🚀",
          mood: BuddyMood.ready,
        ),
      ];
    }

    // 6. Default / Starting
    return const [
      BuddyMessageInfo(
        message: "Okay, let's make this easy. One step! 🚀",
        tag: "Focus Buddy",
        moodEmoji: "🚀",
        mood: BuddyMood.ready,
      ),
      BuddyMessageInfo(
        message: "You've got this. Just start with 5 minutes.",
        tag: "Low Friction",
        moodEmoji: "⏱️",
        mood: BuddyMood.ready,
      ),
      BuddyMessageInfo(
        message: "One task. That's all we need right now.",
        tag: "Bite Sized",
        moodEmoji: "🎯",
        mood: BuddyMood.ready,
      ),
      BuddyMessageInfo(
        message: "Tiny progress is still progress!",
        tag: "Gentle Reminder",
        moodEmoji: "⭐",
        mood: BuddyMood.ready,
      ),
    ];
  }
}
