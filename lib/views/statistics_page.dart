import 'package:flutter/material.dart';
import 'package:tp_flutter_cdm/services/api_service.dart';
import '../models/champion.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  List<Champion> _champions = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadChampions();
  }

  Future<void> _loadChampions() async {
    try {
      final champions = await ApiService().fetchChampions();
      setState(() {
        _champions = champions;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erreur lors du chargement des données.';
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

    // Statistiques globales
    final totalEditions = _champions.length;
    final uniqueChampions = _champions.map((c) => c.country).toSet().length;
    final mostTitled = _champions.fold<Map<String, int>>({}, (acc, champ) {
      acc[champ.country] = (acc[champ.country] ?? 0) + 1;
      return acc;
    });
    final topCountry = mostTitled.entries.reduce((a, b) => a.value >= b.value ? a : b);

    return Scaffold(
      appBar: AppBar(title: Text('Statistiques globales')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre total d’éditions : $totalEditions', style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text('Nombre de pays champions différents : $uniqueChampions', style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text('Pays le plus titré : ${topCountry.key} (${topCountry.value} fois)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            Text('Palmarès :', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ...mostTitled.entries.map((e) => Text('${e.key} : ${e.value} titre(s)')),
          ],
        ),
      ),
    );
  }
} 