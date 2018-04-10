import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../action/task_action.dart';
import '../../i10n/app_localizations.dart';
import '../../model/model.dart';
import '../app_drawer.dart';
import 'new_task_page.dart';

class TasksPage extends StatelessWidget {
  TasksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new AppDrawer(
        selectedNavigation: NavigationId.tasks,
      ),
      appBar: new AppBar(
        title: new Text(AppLocalizations.of(context).title),
        elevation: 0.0,
        actions: <Widget>[],
      ),
      body: new Center(
        child: new StoreConnector<AppState, List<Task>>(
          distinct: true,
          onInit: (store) => store.dispatch(new GetTasksAction()),
          converter: (store) => store.state.tasks,
          builder: (context, tasks) {
            debugPrint("#onGetTasks(tasks=$tasks)");
            // FIXME: EmptyView flickers.
            if (tasks.isEmpty) {
              return new _EmptyView();
            } else {
              return new _TaskListContents(tasks);
            }
          },
        ),
      ),
      floatingActionButton: new Builder(builder: (innerContext) {
        return new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () => _navigateToNewTaskPage(innerContext),
        );
      }),
    );
  }

  void _navigateToNewTaskPage(BuildContext context) {
    Navigator
        .push<bool>(
      context,
      new MaterialPageRoute(
        builder: (context) => new NewTaskPage(),
      ),
    )
        .then((successful) {
      if (successful != null && successful) {
        _showSnackbar(
            context, AppLocalizations.of(context).newTaskSuccessfulToCreate);
      }
    });
  }

  void _showSnackbar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(new SnackBar(
          content: new Text(message),
        ));
  }
}

class _EmptyView extends StatelessWidget {
  _EmptyView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            Icons.assignment_turned_in,
            size: 36.0,
            color: Theme.of(context).primaryColor,
          ),
          new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new Text(AppLocalizations.of(context).noTasks),
          )
        ],
      ),
    );
  }
}

class _TaskListContents extends StatelessWidget {
  final List<Task> _tasks;

  _TaskListContents(
    this._tasks, {
    Key key,
  })  : assert(_tasks?.isNotEmpty),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new _TaskListHeader(),
          new _TaskListView(_tasks),
        ],
      ),
    );
  }
}

class _TaskListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return new Material(
      color: theme.primaryColor,
      elevation: 4.0,
      child: new Column(
        children: <Widget>[
          new Divider(
            height: 2.0,
            color: Colors.white24,
          ),
          new Container(
            constraints: new BoxConstraints(minHeight: 48.0, maxHeight: 48.0),
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(
                  'All TO-DOs',
                  style: new TextStyle(
                    color: Colors.white70,
                    fontSize: theme.textTheme.subhead.fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                new Material(
                  type: MaterialType.card,
                  color: Theme.of(context).primaryColor,
                  child: new InkWell(
                    child: new Row(
                      children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: new Text(
                            'Title',
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: theme.textTheme.subhead.fontSize,
                            ),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: new Icon(
                            Icons.arrow_upward,
                            size: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskListView extends StatelessWidget {
  final List<Task> _tasks;

  _TaskListView(this._tasks);

  @override
  Widget build(BuildContext context) {
    final tiles = _tasks.map((task) {
      return new ListTile(
        leading: new Checkbox(
          value: task.completed,
          onChanged: (newValue) {},
        ),
        title: new Text(
          task.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList(growable: false);

    final dividedTiles = ListTile
        .divideTiles(
          context: context,
          tiles: tiles,
        )
        .toList(growable: false);
    return new Expanded(
      child: new ListView(
        children: dividedTiles,
      ),
    );
  }
}
