class BestPlayer {
  final String year;
  final String bestPlayer;
  final String champion;

  BestPlayer({
    required this.year,
    required this.bestPlayer,
    required this.champion,
  });

  factory BestPlayer.fromJson(Map<String, dynamic> json) {
    return BestPlayer(
      year: json['year'] ?? '',
      bestPlayer: json['bestPlayer'] ?? '',
      champion: json['champion'] ?? '',
    );
  }
} 