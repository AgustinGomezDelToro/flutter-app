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
      theme: ThemeData(primarySwatch: Colors.indigo),
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
