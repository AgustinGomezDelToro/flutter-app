import 'package:flutter/material.dart';
import '../../models/champion.dart';
import '../../models/champion_detail.dart';
import '../../services/api_service.dart';

class ChampionDetailPage extends StatefulWidget {
  final Champion champion;

  const ChampionDetailPage({Key? key, required this.champion}) : super(key: key);

  @override
  State<ChampionDetailPage> createState() => _ChampionDetailPageState();
}

class _ChampionDetailPageState extends State<ChampionDetailPage> {
  ChampionDetail? detail;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  Future<void> fetchDetails() async {
    try {
      final result = await ApiService().fetchChampionDetail(widget.champion.year);
      setState(() {
        detail = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final champion = widget.champion;

    return Scaffold(
      appBar: AppBar(title: Text("${champion.country} - ${champion.year}")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text("Erreur: $error"))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text("Pays: ${detail!.country}", style: TextStyle(fontSize: 20)),
            Text("Année: ${detail!.year}", style: TextStyle(fontSize: 18)),
            Text("Meilleur joueur: ${detail!.bestPlayer}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            if (detail!.bestPlayerStats != null) ...[
              Text("🎯 Statistiques du meilleur joueur:", style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Buts: ${detail!.bestPlayerStats!.goals}"),
              Text("Passes décisives: ${detail!.bestPlayerStats!.assists}"),
              Text("Matchs joués: ${detail!.bestPlayerStats!.matches}"),
              SizedBox(height: 20),
            ],
            Text("📅 Matchs:", style: TextStyle(fontWeight: FontWeight.bold)),
            ...detail!.matches.map((match) => Card(
              child: ListTile(
                title: Text("${match.stage} - ${match.opponent}"),
                subtitle: Text("${match.date} | Score: ${match.score}"),
                trailing: Text(match.location),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
