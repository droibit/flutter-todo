import 'package:flutter/material.dart';

import '../../i10n/app_localizations.dart';
import '../app_drawer.dart';

class TasksPage extends StatefulWidget {
  TasksPage({Key key}) : super(key: key);

  @override
  State createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new AppDrawer(selectedNavigation: NavigationId.tasks),
      appBar: new AppBar(
        title: new Text(AppLocalizations.of(context).title),
      ),
      body: new Center(
        child: const Text('Hello, world'),
      ),
    );
  }
}
