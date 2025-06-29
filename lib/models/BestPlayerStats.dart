class BestPlayerStats {
  final int goals;
  final int assists;
  final int matchesPlayed;
  final int minutesPlayed;
  final int shotsOnTarget;
  final int keyPasses;
  final int penaltiesScored;

  BestPlayerStats({
    required this.goals,
    required this.assists,
    required this.matchesPlayed,
    required this.minutesPlayed,
    required this.shotsOnTarget,
    required this.keyPasses,
    required this.penaltiesScored,
  });

  factory BestPlayerStats.fromJson(Map<String, dynamic> json) {
    return BestPlayerStats(
      goals: json['goals'] ?? 0,
      assists: json['assists'] ?? 0,
      matchesPlayed: json['matchesPlayed'] ?? 0,
      minutesPlayed: json['minutesPlayed'] ?? 0,
      shotsOnTarget: json['shotsOnTarget'] ?? 0,
      keyPasses: json['keyPasses'] ?? 0,
      penaltiesScored: json['penaltiesScored'] ?? 0,
    );
  }
}
