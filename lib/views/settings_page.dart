import 'package:flutter/material.dart';
import 'package:tp_flutter_cdm/services/api_service.dart';
import '../models/champion.dart';
import 'champion_detail_page.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<Champion> _champions = [];
  List<Champion> _filtered = [];
  bool _loading = true;
  String? _error;
  String _query = '';

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
        _filtered = champions;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erreur lors du chargement des champions.';
        _loading = false;
      });
    }
  }

  void _onSearch(String value) {
    setState(() {
      _query = value;
      _filtered = _champions.where((champ) =>
        champ.country.toLowerCase().contains(value.toLowerCase()) ||
        champ.year.toString().contains(value)
      ).toList();
    });
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
      appBar: AppBar(title: Text("Paramètres")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Rechercher un champion (pays ou année)',
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearch,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (context, index) {
                final champ = _filtered[index];
                return ListTile(
                  title: Text('${champ.country} (${champ.year})'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChampionDetailPage(
                          champion: champ,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
