import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../models/champion.dart';
import '../models/champion_detail.dart';
import '../constants/api_constants.dart';
import '../models/best_player.dart';

class ApiService {
  Future<List<Champion>> fetchChampions() async {
    final response = await http.get(
      baseUri.replace(path: '/api/champions'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Champion.fromJson(e)).toList();
    } else {
      debugPrint('Erreur fetchChampions - Status code: ${response.statusCode}');
      debugPrint('Body: ${response.body}');
      throw Exception('Erreur lors du chargement des champions.');
    }
  }

  // ✅ Versión única y correcta con la ruta actualizada
  Future<ChampionDetail> fetchChampionDetail(int year) async {
    final response = await http.get(
      baseUri.replace(
        path: '/api/championsByYear/$year',
      ),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return ChampionDetail.fromJson(decoded);
    } else {
      debugPrint('Erreur fetchChampionDetail - Status code: ${response.statusCode}');
      debugPrint('Body: ${response.body}');
      throw Exception('Erreur lors du chargement des détails du champion.');
    }
  }

  Future<List<int>> fetchYears() async {
    final response = await http.get(
      baseUri.replace(path: '/api/years'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      // Si l'API retourne des strings, on convertit en int
      return data.map((e) => int.tryParse(e.toString()) ?? 0).toList();
    } else {
      debugPrint('Erreur fetchYears - Status code: ${response.statusCode}');
      debugPrint('Body: ${response.body}');
      throw Exception('Erreur lors du chargement des années.');
    }
  }

  Future<List<BestPlayer>> fetchBestPlayers() async {
    final response = await http.get(
      baseUri.replace(path: '/api/bestPlayers'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => BestPlayer.fromJson(e)).toList();
    } else {
      debugPrint('Erreur fetchBestPlayers - Status code:  {response.statusCode}');
      debugPrint('Body:  {response.body}');
      throw Exception('Erreur lors du chargement des meilleurs joueurs.');
    }
  }
}
