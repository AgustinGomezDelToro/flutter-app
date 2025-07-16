import 'package:flutter/material.dart';
import 'package:tp_flutter_cdm/services/api_service.dart';
import '../models/champion.dart';
import '../models/best_player.dart';

class VainqueursPage extends StatefulWidget {
  @override
  _VainqueursPageState createState() => _VainqueursPageState();
}

class _VainqueursPageState extends State<VainqueursPage> {
  List<Champion> _champions = [];
  List<BestPlayer> _bestPlayers = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final champions = await ApiService().fetchChampions();
      final bestPlayers = await ApiService().fetchBestPlayers();
      setState(() {
        _champions = champions;
        _bestPlayers = bestPlayers;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erreur lors du chargement des données.';
        _loading = false;
      });
    }
  }

  String getBestPlayerForYear(int year) {
    final found = _bestPlayers.firstWhere(
      (bp) => int.tryParse(bp.year) == year,
      orElse: () => BestPlayer(year: '', bestPlayer: '', champion: ''),
    );
    return found.bestPlayer.isNotEmpty ? found.bestPlayer : 'Joueur inconnu';
  }

  Color getColor(int index) {
    final colors = [
      Colors.blue.shade300,
      Colors.purple.shade300,
      Colors.green.shade300,
      Colors.orange.shade300,
      Colors.pink.shade200,
      Colors.teal.shade300,
      Colors.red.shade300,
      Colors.amber.shade400,
    ];
    return colors[index % colors.length];
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

    final sorted = List<Champion>.from(_champions)
      ..sort((a, b) => b.year.compareTo(a.year));

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade100, Colors.indigo.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Vainqueurs', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.indigo.shade400,
          elevation: 0,
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(16),
          itemCount: sorted.length,
          separatorBuilder: (_, __) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final champ = sorted[index];
            final bestPlayer = getBestPlayerForYear(champ.year);
            return Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: getColor(index).withOpacity(0.85),
              child: ListTile(
                leading: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${champ.year}',
                    style: TextStyle(
                      color: getColor(index),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                title: Text(
                  champ.country,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(1,1))],
                  ),
                ),
                subtitle: Text(
                  'Meilleur joueur : $bestPlayer',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(1,1))],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
} 