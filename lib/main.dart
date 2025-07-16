import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'views/auth/login_page.dart';
import 'views/dashboard.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(MyWorldCupApp());
}

class MyWorldCupApp extends StatelessWidget {
  final _secureStorage = const FlutterSecureStorage();

  Future<bool> _isLoggedIn() async {
    String? token;

    if (kIsWeb) {
      // En Web usamos SharedPreferences como alternativa
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('auth_token');
    } else {
      token = await _secureStorage.read(key: 'auth_token');
    }

    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coupe du Monde App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.blue.shade50,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo.shade400,
          foregroundColor: Colors.white,
          elevation: 4,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.indigo.shade900,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            color: Colors.indigo.shade800,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo.shade400,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            elevation: 3,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Colors.indigo.shade700),
          prefixIconColor: Colors.indigo.shade400,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 6,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        ),
        dividerColor: Colors.indigo.shade100,
      ),
      home: FutureBuilder<bool>(
        future: _isLoggedIn(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return snapshot.data! ? Dashboard() : LoginPage();
        },
      ),
    );
  }
}
