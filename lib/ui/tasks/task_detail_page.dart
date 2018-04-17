import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../i10n/app_localizations.dart';
import '../../model/model.dart';

class TaskDetailPage extends StatelessWidget {
  final String _taskId;

  TaskDetailPage(this._taskId);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, Task>(
      distinct: true,
      converter: (store) =>
          store.state.tasks.firstWhere((task) => task.id == _taskId),
      builder: (context, task) {
        return new Scaffold(
          appBar: new AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: new Text(AppLocalizations.of(context).title),
          ),
          body: new _TaskDetailView(task),
        );
      },
    );
  }
}

class _TaskDetailView extends StatelessWidget {

  final Task _task;

  _TaskDetailView(this._task);

  @override
  Widget build(BuildContext context) {
    return new Text(_task.title);
  }
}