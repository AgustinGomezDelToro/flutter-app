import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tp_flutter_cdm/services/storage_service.dart';
import '../constants/api_constants.dart';

class AuthService {
  final String baseUrl = baseUri.toString();
  final StorageService _storage = StorageService();

  // Login → devuelve el token si fue exitoso, null si no
  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      final token = jsonDecode(response.body)['token'];
      await _storage.write('auth_token', token);
      print("✅ TOKEN: $token");
      return token;
    }

    print("❌ LOGIN FAILED:  {response.statusCode}");
    return null;
  }

  // Register
  Future<bool> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    return response.statusCode == 201;
  }

  // Obtener el token guardado
  Future<String?> getToken() async {
    return await _storage.read('auth_token');
  }

  // Eliminar el token (logout)
  Future<void> logout() async {
    await _storage.delete('auth_token');
  }
}
