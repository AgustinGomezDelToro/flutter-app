import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/champion.dart';
import '../models/champion_detail.dart';
import '../services/auth_service.dart';
import '../constants/api_constants.dart';

class ApiService {
  Future<List<Champion>> fetchChampions() async {
    final token = await AuthService().getToken();
    final response = await http.get(
      baseUri.replace(path: '/api/champions'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Champion.fromJson(e)).toList();
    } else {
      throw Exception('Erreur lors du chargement des champions.');
    }
  }

  // ✅ Versión única y correcta con la ruta actualizada
  Future<ChampionDetail> fetchChampionDetail(int year) async {
    final token = await AuthService().getToken();

    final response = await http.get(
      baseUri.replace(
        path: '/api/championsByYear/$year',
      ),

      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return ChampionDetail.fromJson(decoded);
    } else {
      throw Exception('Erreur lors du chargement des détails du champion.');
    }
  }
}
