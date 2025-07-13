import 'package:flutter/material.dart';
import 'champions_page.dart';
import 'years_page.dart';
import 'best_players_page.dart';
import 'settings_page.dart';
import 'statistics_page.dart';
import 'package:tp_flutter_cdm/views/champions_page.dart';
import 'package:tp_flutter_cdm/views/years_page.dart';
import 'package:tp_flutter_cdm/views/best_players_page.dart';
import 'package:tp_flutter_cdm/views/settings_page.dart';


class Dashboard extends StatelessWidget {
  final List<_DashboardItem> items = [
    _DashboardItem(title: "Champions", widget: ChampionsPage()),
    _DashboardItem(title: "Années", widget: YearsPage()),
    _DashboardItem(title: "Meilleurs joueurs", widget: BestPlayersPage()),
    _DashboardItem(title: "Statistiques globales", widget: StatisticsPage()),
    _DashboardItem(title: "Paramètres", widget: SettingsPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tableau de bord")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.title),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => item.widget));
            },
          );
        },
      ),
    );
  }
}

class _DashboardItem {
  final String title;
  final Widget widget;
  _DashboardItem({required this.title, required this.widget});
}
