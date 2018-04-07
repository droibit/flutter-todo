import 'package:flutter/material.dart';

import '../../i10n/app_localizations.dart';
import '../app_drawer.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPage({Key key}) : super(key: key);

  @override
  State createState() => new StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    final title = AppLocalizations.of(context).statistics;
    return new Scaffold(
      drawer: new AppDrawer(selectedNavigation: NavigationId.statistics),
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: new Text(title),
      ),
      body: new Center(
        child: new Text(title),
      ),
    );
  }
}
