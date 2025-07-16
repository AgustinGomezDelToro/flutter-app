import 'package:flutter/material.dart';
import 'package:tp_flutter_cdm/services/api_service.dart';
import '../models/champion.dart';

class PalmaresPage extends StatefulWidget {
  @override
  _PalmaresPageState createState() => _PalmaresPageState();
}

class _PalmaresPageState extends State<PalmaresPage> {
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

  Color getColor(int index) {
    // Palette de couleurs modernes
    final colors = [
      Colors.amber.shade400,
      Colors.blue.shade300,
      Colors.purple.shade300,
      Colors.green.shade300,
      Colors.orange.shade300,
      Colors.pink.shade200,
      Colors.teal.shade300,
      Colors.red.shade300,
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

    // Calcul du palmarès
    final palmares = <String, int>{};
    for (var champ in _champions) {
      palmares[champ.country] = (palmares[champ.country] ?? 0) + 1;
    }
    final sorted = palmares.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade400, Colors.blue.shade100],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Palmarès', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.indigo.shade400,
          elevation: 0,
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(16),
          itemCount: sorted.length,
          separatorBuilder: (_, __) => SizedBox(height: 12),
          itemBuilder: (context, index) {
            final entry = sorted[index];
            return Card(
              elevation: 6,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              color: getColor(index).withOpacity(0.85),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: getColor(index),
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                title: Text(
                  entry.key,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                    shadows: [Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(1,1))],
                  ),
                ),
                trailing: Text(
                  '${entry.value} titre(s)',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
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