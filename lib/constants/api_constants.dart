const String baseUrl = String.fromEnvironment(
  'API_BASE_URL',
  defaultValue: 'http://localhost:4000',
);

final Uri baseUri = Uri.parse(baseUrl);
