class BestPlayerStats {
  final int goals;
  final int assists;
  final int matches;

  BestPlayerStats({
    required this.goals,
    required this.assists,
    required this.matches,
  });

  factory BestPlayerStats.fromJson(Map<String, dynamic> json) {
    return BestPlayerStats(
      goals: json['goals'] ?? 0,
      assists: json['assists'] ?? 0,
      matches: json['matches'] ?? 0,
    );
  }
}
