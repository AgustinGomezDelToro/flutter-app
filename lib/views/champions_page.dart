import 'package:flutter/material.dart';
import 'package:tp_flutter_cdm/services/api_service.dart';
import '../../models/champion.dart';
import 'champion_detail_page.dart';

class ChampionsPage extends StatefulWidget {
  @override
  _ChampionsPageState createState() => _ChampionsPageState();
}

class _ChampionsPageState extends State<ChampionsPage> {
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
      final champions = await ApiService().fetchChampions(); // debe devolver List<Champion>

      setState(() {
        _champions = champions;
        _loading = false;
      });
    } catch (e) {
      print("❌ ERROR CHAMPIONS: $e");
      setState(() {
        _error = 'Erreur lors du chargement des champions.';
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
      appBar: AppBar(title: Text('Champions')),
      body: ListView.builder(
        itemCount: _champions.length,
        itemBuilder: (context, index) {
          final champ = _champions[index];
          return ListTile(
            title: Text(champ.country),
            subtitle: Text('Année: ${champ.year}'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChampionDetailPage(champion: champ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
