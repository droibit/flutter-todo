import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../action/action.dart';
import '../../i10n/app_localizations.dart';
import '../../model/model.dart';
import '../../uitls/optional.dart';
import '../app_drawer.dart';
import 'new_task_page.dart';

class TasksPage extends StatelessWidget {
  TasksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return new StoreConnector<AppState, _TasksViewModel>(
      distinct: true,
      onInit: (store) => store.dispatch(new GetTasksAction()),
      converter: (store) => new _TasksViewModel.from(store),
      builder: (context, viewModel) {
        return new Scaffold(
          drawer: new AppDrawer(
            selectedNavigation: NavigationId.tasks,
          ),
          appBar: new AppBar(
            title: new Text(localizations.title),
            elevation: 0.0,
            actions: <Widget>[
              new _TasksFilterPopupMenu(viewModel.onFilterChanged),
              new _OverflowPopupMenu(
                  viewModel.tasksSortBy,
                  viewModel.onClearCompletedTasksSelected,
                  viewModel.onTasksSortByChanged),
            ],
          ),
          body: new _TaskListContents(viewModel),
          floatingActionButton: new Builder(builder: (innerContext) {
            return new FloatingActionButton(
              child: new Icon(Icons.add),
              onPressed: () => _navigateToNewTaskPage(innerContext),
            );
          }),
        );
      },
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
    Scaffold.of(context).showSnackBar(
          new SnackBar(
            content: new Text(message),
          ),
        );
  }
}

class _TasksViewModel {
  final List<Task> tasks;

  final TasksFilter filter;

  final Optional<TasksSortBy> tasksSortBy;

  final Function(TasksFilter) onFilterChanged;

  final Function(Task, bool) onTaskCheckChanged;

  final Function() onClearCompletedTasksSelected;

  final Function(TasksSortBy) onTasksSortByChanged;

  factory _TasksViewModel.from(Store<AppState> store) {
    final currentFilter = store.state.tasksFilter;
    final currentTaksSortBy = store.state.tasksSortBy;
    return new _TasksViewModel._internal(
        tasks: _filterTask(store.state.tasks, currentFilter),
        filter: store.state.tasksFilter,
        tasksSortBy: store.state.tasksSortBy,
        onFilterChanged: (newFilter) {
          if (currentFilter != newFilter) {
            store.dispatch(new ChangeTasksFilterAction(newFilter));
            debugPrint("#onFilterChanged($newFilter)");
          }
        },
        onTaskCheckChanged: (task, newValue) {
          if (newValue) {
            store.dispatch(new CompleteTaskAction(task));
          } else {
            store.dispatch(new ActivateTaskAction(task));
          }
          debugPrint("#onTaskCheckChanged($newValue, $task)");
        },
        onClearCompletedTasksSelected: () {
          debugPrint("#onClearCompletedTasksSelected()");
        },
        onTasksSortByChanged: (newTasksSortBy) {
          if (currentTaksSortBy != Optional.of(newTasksSortBy)) {
            // TODO: dispatch action.
          }
          debugPrint("#onTasksSortByChanged()");
        });
  }

  _TasksViewModel._internal({
    @required this.tasks,
    @required this.filter,
    @required this.tasksSortBy,
    @required this.onFilterChanged,
    @required this.onTaskCheckChanged,
    @required this.onClearCompletedTasksSelected,
    @required this.onTasksSortByChanged,
  });

  static List<Task> _filterTask(List<Task> src, TasksFilter filter) {
    return src.where((task) {
      switch (filter) {
        case TasksFilter.all:
          return true;
        case TasksFilter.active:
          return task.isActive;
        case TasksFilter.completed:
          return task.completed;
      }
    }).toList(growable: false);
  }
}

class _TasksFilterPopupMenu extends StatelessWidget {
  final Function(TasksFilter) _onChanged;

  _TasksFilterPopupMenu(this._onChanged);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final items = <TasksFilter, String>{
      TasksFilter.all: localizations.todoListFilterAll,
      TasksFilter.active: localizations.todoListFilterActive,
      TasksFilter.completed: localizations.todoListFilterCompleted,
    };
    return new PopupMenuButton<TasksFilter>(
      icon: new Icon(
        Icons.filter_list,
        color: Colors.white,
      ),
      itemBuilder: (context) => items.entries.map((entry) {
            return new PopupMenuItem<TasksFilter>(
              value: entry.key,
              child: new Text(entry.value),
            );
          }).toList(),
      onSelected: _onChanged,
    );
  }
}

enum _OverflowMenuItem {
  changeTasksSortBy,
  clearCompletedTasks,
}

class _OverflowPopupMenu extends StatelessWidget {
  final Optional<TasksSortBy> _tasksSortBy;

  final Function() _onClearCompletedTasksSelected;

  final Function(TasksSortBy) _onTasksSortByChanged;

  _OverflowPopupMenu(this._tasksSortBy, this._onClearCompletedTasksSelected,
      this._onTasksSortByChanged);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final items = {
      _OverflowMenuItem.changeTasksSortBy: localizations.todoListSortBy,
      _OverflowMenuItem.clearCompletedTasks:
          localizations.todoListClearCompleted,
    };
    return new PopupMenuButton<_OverflowMenuItem>(
      itemBuilder: (context) => items.entries.map((entry) {
            return new PopupMenuItem(
              value: entry.key,
              child: new Text(entry.value),
            );
          }).toList(),
      onSelected: (menuItem) {
        switch (menuItem) {
          case _OverflowMenuItem.clearCompletedTasks:
            _onClearCompletedTasksSelected();
            break;
          case _OverflowMenuItem.changeTasksSortBy:
            _tasksSortBy
                .ifPresent((v) => showSortByTasksBottomSheet(context, v));
            break;
        }
      },
    );
  }

  void showSortByTasksBottomSheet(
      BuildContext context, TasksSortBy tasksSortBy) async {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);

    final items = <SortBy, String>{
      SortBy.title: localizations.todoListSortByTitle,
      SortBy.created_date: localizations.todoListSortByCreatedDate
    }.entries.map((entry) {
      return new ListTile(
        title: new Text(entry.value),
        onTap: () {
          Navigator.of(context).pop(entry.key);
        },
        trailing: (entry.key == tasksSortBy.sortBy)
            ? new Icon(
                Icons.check,
                color: theme.primaryColor,
              )
            : null,
      );
    });

    final selectedSortBy = await showModalBottomSheet<SortBy>(
      context: context,
      builder: (context) {
        return new Container(
            child: new ListView(
          shrinkWrap: true,
          children: <Widget>[
            new ListTile(
              title: new Text(
                localizations.todoListSortBy,
                style: new TextStyle(color: theme.primaryColorDark),
              ),
            ),
          ]..addAll(items),
        ));
      },
    );

    if (selectedSortBy != null) {
      _onTasksSortByChanged(tasksSortBy.copyWith(sortBy: selectedSortBy));
    }
  }
}

class _TaskListContents extends StatelessWidget {
  final _TasksViewModel _viewModel;

  _TaskListContents(
    this._viewModel, {
    Key key,
  })  : assert(_viewModel != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_viewModel.tasks.isEmpty) {
      return new _EmptyView();
    } else {
      return new _TaskListView(_viewModel);
    }
  }
}

class _TaskListView extends StatelessWidget {
  final _TasksViewModel _viewModel;

  _TaskListView(
    this._viewModel, {
    Key key,
  })  : assert(_viewModel != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          _buildHeader(context),
          _buildTaskList(context),
        ],
      ),
    );
  }

  Widget _buildTaskList(BuildContext context) {
    final tiles = _viewModel.tasks.map((task) {
      return new ListTile(
        leading: new Checkbox(
          value: task.completed,
          onChanged: (newValue) {
            _viewModel.onTaskCheckChanged(task, newValue);
          },
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

  Widget _buildHeader(BuildContext context) {
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
                  resolveTitle(context, _viewModel.filter),
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

  String resolveTitle(BuildContext context, TasksFilter filter) {
    final localizations = AppLocalizations.of(context);
    switch (filter) {
      case TasksFilter.all:
        return localizations.todoListHeaderAll;
      case TasksFilter.active:
        return localizations.todoListHeaderActive;
      case TasksFilter.completed:
        return localizations.todoListHeaderCompleted;
      default:
        throw new AssertionError("Invalid filter: $filter");
    }
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
