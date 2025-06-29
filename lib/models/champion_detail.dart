import '../models/match.dart';
import '../services/bestPlayerStats.dart';

class ChampionDetail {
  final String country;
  final int year;
  final String bestPlayer;
  final List<Match> matches;
  final BestPlayerStats? bestPlayerStats;

  ChampionDetail({
    required this.country,
    required this.year,
    required this.bestPlayer,
    required this.matches,
    required this.bestPlayerStats,
  });

  factory ChampionDetail.fromJson(Map<String, dynamic> json) {
    return ChampionDetail(
      country: json['champion'] ?? 'Inconnu',
      year: int.tryParse(json['year'].toString()) ?? 0,
      bestPlayer: json['bestPlayer'] ?? 'Joueur inconnu',
      matches: (json['matches'] as List<dynamic>?)
          ?.map((e) => Match.fromJson(e))
          .toList() ??
          [],
      bestPlayerStats: json['bestPlayerStats'] != null
          ? BestPlayerStats.fromJson(json['bestPlayerStats'])
          : null,
    );
  }
}
