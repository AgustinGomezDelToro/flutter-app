import 'package:flutter/material.dart';
import 'package:tp_flutter_cdm/services/auth_service.dart';
import 'package:tp_flutter_cdm/views/dashboard.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  bool _loading = false;
  String? _error;

  void _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final token = await _authService.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      if (token != null) {
        // Ya se guardó en el storage desde AuthService.login()
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => Dashboard()),
        );
      } else {
        setState(() => _error = "Email ou mot de passe incorrect.");
      }
    } catch (e) {
      print("❌ ERROR LOGIN: $e");
      setState(() => _error = "Erreur lors de la connexion.");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Connexion")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Mot de passe'),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(_error!, style: TextStyle(color: Colors.red)),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _login,
              child: _loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Se connecter"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterPage()));
              },
              child: Text("Pas encore inscrit ? Crée un compte"),
            )
          ],
        ),
      ),
    );
  }
}
