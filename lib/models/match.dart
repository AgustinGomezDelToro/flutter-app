class Match {
  final String stage;
  final String opponent;
  final String score;
  final String date;
  final String location;

  Match({
    required this.stage,
    required this.opponent,
    required this.score,
    required this.date,
    required this.location,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      stage: json['stage'] ?? '',
      opponent: json['opponent'] ?? '',
      score: json['score'] ?? '',
      date: json['date'] ?? '',
      location: json['location'] ?? '',
    );
  }
}
