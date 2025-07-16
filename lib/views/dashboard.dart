import 'package:flutter/material.dart';
import 'champions_page.dart';
import 'years_page.dart';
import 'best_players_page.dart';
import 'statistics_page.dart';
import 'search_page.dart';
import 'palmares_page.dart';
import 'vainqueurs_page.dart';
import 'package:tp_flutter_cdm/views/champions_page.dart';
import 'package:tp_flutter_cdm/views/years_page.dart';
import 'package:tp_flutter_cdm/views/best_players_page.dart';
import 'package:tp_flutter_cdm/services/auth_service.dart';
import 'auth/login_page.dart';


class Dashboard extends StatelessWidget {
  final List<_DashboardItem> items = [
    _DashboardItem(title: "Champions", widget: ChampionsPage()),
    _DashboardItem(title: "Années", widget: YearsPage()),
    _DashboardItem(title: "Meilleurs joueurs", widget: BestPlayersPage()),
    _DashboardItem(title: "Statistiques globales", widget: StatisticsPage()),
    _DashboardItem(title: "Recherche", widget: SearchPage()),
    _DashboardItem(title: "Palmarès", widget: PalmaresPage()),
    _DashboardItem(title: "Vainqueurs", widget: VainqueursPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tableau de bord"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Déconnexion',
            onPressed: () async {
              await AuthService().logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
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
