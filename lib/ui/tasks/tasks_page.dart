import 'package:flutter/material.dart';

import '../app_drawer.dart';
import '../../i10n/app_localizations.dart';

class TasksPage extends StatefulWidget {

  TasksPage({Key key}) : super(key: key);

  @override
  State createState() => TasksPageState();
}

class TasksPageState extends State<TasksPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new AppDrawer(
        selectedNavigation: NavigationId.todoList,
        onNavigationSelect: _onNavigationSelect
      ),
      appBar: new AppBar(
        title: new Text(AppLocalizations.of(context).title),
      ),
      body: new Center(
        child: const Text('Hello, world'),
      ),
    );
  }

  void _onNavigationSelect(NavigationId id) {
    print("#onNavigationSelect($id)");
  }
}