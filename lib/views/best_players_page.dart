import 'package:flutter/material.dart';
import 'package:tp_flutter_cdm/services/api_service.dart';
import '../models/best_player.dart';

class BestPlayersPage extends StatefulWidget {
  @override
  _BestPlayersPageState createState() => _BestPlayersPageState();
}

class _BestPlayersPageState extends State<BestPlayersPage> {
  List<BestPlayer> _players = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadBestPlayers();
  }

  Future<void> _loadBestPlayers() async {
    try {
      final players = await ApiService().fetchBestPlayers();
      setState(() {
        _players = players;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erreur lors du chargement des meilleurs joueurs.';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          style: TextStyle(color: Colors.red, fontSize: 18),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("Meilleurs joueurs")),
      body: ListView.builder(
        itemCount: _players.length,
        itemBuilder: (context, index) {
          final player = _players[index];
          return ListTile(
            title: Text(player.bestPlayer),
            subtitle: Text('Année : ${player.year} — Pays : ${player.champion}'),
          );
        },
      ),
    );
  }
}
