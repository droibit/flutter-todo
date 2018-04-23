import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

import '../../action/action.dart';
import '../../i10n/app_localizations.dart';
import '../../model/model.dart';
import 'edit_task_page.dart';

class TaskDetailPage extends StatelessWidget {
  final String _taskId;

  TaskDetailPage(this._taskId);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _TaskViewModel>(
      distinct: true,
      converter: (store) => new _TaskViewModel.from(store, _taskId),
      builder: (context, viewModel) {
        return new Scaffold(
          appBar: new AppBar(
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: new Text(AppLocalizations.of(context).title),
            actions: <Widget>[],
          ),
          body: new _TaskDetailView(viewModel),
          floatingActionButton: new Builder(
            builder: (innerContext) {
              return new FloatingActionButton(
                child: new Icon(Icons.edit),
                onPressed: () {
                  _navigateToEditTaskPage(innerContext, viewModel.task);
                },
              );
            },
          ),
        );
      },
    );
  }

  void _navigateToEditTaskPage(BuildContext context, Task targetTask) async {
    final successful = await Navigator.push<bool>(
      context,
      new MaterialPageRoute(
        builder: (context) => new EditTaskPage.updateTask(targetTask),
      ),
    );

    if (successful != null && successful) {
      _showSnackbar(
          context, AppLocalizations.of(context).editTaskSuccessfulToUpdate);
    }
  }
}

class _TaskViewModel {
  final Task task;

  final Function(Task, bool) onTaskCheckChanged;

  _TaskViewModel._({
    this.task,
    this.onTaskCheckChanged,
  })  : assert(task != null),
        assert(onTaskCheckChanged != null);

  factory _TaskViewModel.from(Store<AppState> store, String taskId) {
    return new _TaskViewModel._(
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
    if (task.description.trim().isNotEmpty) {
      taskDetail.addAll(<Widget>[
        new SizedBox(
          height: 8.0,
        ),
        new Text(
          task.description,
          style: theme.textTheme.subhead,
        )
      ]);
    }
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        completedCheckbox,
        new Expanded(
          child: new Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: taskDetail,
            ),
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

void _showSnackbar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: new Text(message),
        ),
      );
}
