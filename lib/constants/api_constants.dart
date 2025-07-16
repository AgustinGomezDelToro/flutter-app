import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = kIsWeb
    ? (dotenv.env['API_BASE_URL_WEB'] ?? 'http://localhost:4000')
    : (dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:4000');
final Uri baseUri = Uri.parse(baseUrl);