class GamificationModel {
  final int xp;
  final int streak;
  final DateTime? lastCompletedDate;
  final List<String> achievementDays;

  GamificationModel({
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

  factory GamificationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return GamificationModel(
      xp: json['xp'] ?? 0,
      streak: json['streak'] ?? 0,
      lastCompletedDate:
          json['lastCompletedDate'] != null
              ? DateTime.parse(
                  json['lastCompletedDate'],
                )
              : null,
      achievementDays:
          List<String>.from(
        json['achievementDays'] ?? [],
      ),
    );
  }
}