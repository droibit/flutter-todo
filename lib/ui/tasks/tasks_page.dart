import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../action/task_action.dart';
import '../../i10n/app_localizations.dart';
import '../../model/model.dart';
import '../app_drawer.dart';

class TasksPage extends StatelessWidget {
  TasksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new AppDrawer(
          selectedNavigation: NavigationId.tasks,
      ),
      appBar: new AppBar(title: new Text(AppLocalizations.of(context).title)),
      body: new Center(
        child: new StoreConnector<AppState, List<Task>>(
          distinct: true,
          onInit: (store) => store.dispatch(new GetTasksAction()),
          converter: (store) => store.state.tasks,
          builder: (context, tasks) {
            if (tasks.isEmpty) {
              return new _EmptyView();
            } else {
              return new _TaskListView(tasks);
            }
          },
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  _EmptyView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: const Text('No TO-DO.'),
    );
  }
}

class _TaskListView extends StatelessWidget {
  final List<Task> _tasks;

  _TaskListView(
    this._tasks, {
    Key key,
  })  : assert(_tasks?.isNotEmpty),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: const Text('TO-DO.'),
    );
  }
}
