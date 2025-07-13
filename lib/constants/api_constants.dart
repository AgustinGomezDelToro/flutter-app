import 'package:flutter_dotenv/flutter_dotenv.dart';

final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:4000';
final Uri baseUri = Uri.parse(baseUrl);