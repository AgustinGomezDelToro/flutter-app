import 'package:flutter/material.dart';
import 'package:tp_flutter_cdm/services/api_service.dart';
import '../../models/champion.dart';
import 'champion_detail_page.dart';

class YearsPage extends StatefulWidget {
  @override
  _YearsPageState createState() => _YearsPageState();
}

class _YearsPageState extends State<YearsPage> {
  List<int> _years = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadYears();
  }

  Future<void> _loadYears() async {
    try {
      final years = await ApiService().fetchYears();
      setState(() {
        _years = years;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Erreur lors du chargement des années.';
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
      appBar: AppBar(title: Text("Années")),
      body: ListView.builder(
        itemCount: _years.length,
        itemBuilder: (context, index) {
          final year = _years[index];
          return ListTile(
            title: Text(year.toString()),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChampionDetailPage(
                    champion: Champion(
                      country: '',
                      year: year,
                      bestPlayer: '',
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}