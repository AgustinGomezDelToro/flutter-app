class Champion {
  final String country;
  final int year;
  final String bestPlayer;

  Champion({
    required this.country,
    required this.year,
    required this.bestPlayer,
  });

  factory Champion.fromJson(Map<String, dynamic> json) {
    return Champion(
      country: json['champion'] ?? 'Inconnu',
      year: int.tryParse(json['year'].toString()) ?? 0,
      bestPlayer: json['bestPlayer'] ?? 'Joueur inconnu',
    );
  }
}


class Match {
  final String stage;
  final String opponent;
  final String score;
  final String date;

  Match({
    required this.stage,
    required this.opponent,
    required this.score,
    required this.date,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      stage: json['stage'] ?? '',
      opponent: json['opponent'] ?? '',
      score: json['score'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
