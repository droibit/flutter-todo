import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

import '../../action/action.dart';
import '../../i10n/app_localizations.dart';
import '../../model/model.dart';

class TaskDetailPage extends StatelessWidget {
  final String _taskId;

  TaskDetailPage(this._taskId);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _TaskViewModel>(
      distinct: true,
      converter: (store) => new _TaskViewModel.from(store, _taskId),
      builder: (context, task) {
        return new Scaffold(
          appBar: new AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: new Text(AppLocalizations.of(context).title),
            actions: <Widget>[],
          ),
          body: new _TaskDetailView(task),
          floatingActionButton: new FloatingActionButton(
            child: new Icon(Icons.edit),
            onPressed: () {},
          ),
        );
      },
    );
  }
}

class _TaskViewModel {
  final Task task;

  final Function(Task, bool) onTaskCheckChanged;

  _TaskViewModel._internal({
    this.task,
    this.onTaskCheckChanged,
  })  : assert(task != null),
        assert(onTaskCheckChanged != null);

  factory _TaskViewModel.from(Store<AppState> store, String taskId) {
    return new _TaskViewModel._internal(
      task: store.state.tasks.firstWhere((task) => task.id == taskId),
      onTaskCheckChanged: (task, newValue) {
        if (newValue) {
          store.dispatch(new CompleteTaskAction(task));
        } else {
          store.dispatch(new ActivateTaskAction(task));
        }
        debugPrint("#onTaskCheckChanged($newValue, $task)");
      },
    );
  }
}

class _TaskDetailView extends StatelessWidget {
  final _TaskViewModel _viewModel;

  _TaskDetailView(this._viewModel);

  @override
  Widget build(BuildContext context) {
    final task = _viewModel.task;
    return new Container(
      padding: const EdgeInsets.all(16.0),
      child: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[]
            ..add(_buildTitleSection(context, task))
            ..add(_buildTimestamp(context, task)),
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context, Task task) {
    final theme = Theme.of(context);
    final completedCheckbox = new SizedBox(
      width: 48.0,
      height: 48.0,
      child: new Center(
        child: new Checkbox(
          value: task.completed,
          onChanged: (newValue) {
            _viewModel.onTaskCheckChanged(_viewModel.task, newValue);
          },
        ),
      ),
    );

    final taskDetail = <Widget>[
      new Text(
        task.title,
        style: theme.textTheme.title,
      ),
    ];
    if (task.description.isNotEmpty) {
      taskDetail.add(new Text(
        task.description,
        style: theme.textTheme.subhead,
      ));
    }
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        completedCheckbox,
        new Expanded(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: taskDetail,
          ),
        ),
      ],
    );
  }

  Widget _buildTimestamp(BuildContext context, Task task) {
    return new Row(
      children: <Widget>[
        new SizedBox(
          width: 48.0,
          height: 48.0,
          child: new Center(
            child: new Icon(
              Icons.today,
              color: Colors.black54,
            ),
          ),
        ),
        new Text(new DateFormat.yMMMMd().add_Hm().format(task.timestamp))
      ],
    );
  }
}
