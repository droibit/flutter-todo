import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../i10n/app_localizations.dart';
import '../../model/model.dart';
import '../app_drawer.dart';

class StatisticsPage extends StatelessWidget {
  StatisticsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, List<Task>>(
      distinct: true,
      converter: (store) => store.state.tasks,
      builder: (context, tasks) {
        return new Scaffold(
          drawer: new AppDrawer(selectedNavigation: NavigationId.statistics),
          appBar: new AppBar(
            leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
            title: new Text(AppLocalizations.of(context).statistics),
          ),
          body: new _StatisticsContents(tasks),
        );
      },
    );
  }
}

class _StatisticsContents extends StatelessWidget {
  final List<Task> tasks;

  _StatisticsContents(this.tasks);

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return new _EmptyView();
    } else {
      return new _TaskStatisticsView(new _StatisticsViewModel.from(tasks));
    }
  }
}

class _StatisticsViewModel {
  final int activeCount;

  final int completedCount;

  _StatisticsViewModel({
    @required this.activeCount,
    @required this.completedCount,
  })  : assert(activeCount != null),
        assert(completedCount != null);

  factory _StatisticsViewModel.from(List<Task> tasks) {
    return new _StatisticsViewModel(
      activeCount: tasks.where((t) => t.isActive).length,
      completedCount: tasks.where((t) => !t.isActive).length,
    );
  }
}

class _TaskStatisticsView extends StatelessWidget {
  final _StatisticsViewModel _viewModel;

  _TaskStatisticsView(this._viewModel);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final textStyle = Theme.of(context).textTheme.subhead;
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            "${localizations.statisticsActiveTasks} ${_viewModel.activeCount}",
            style: textStyle,
          ),
          new SizedBox(
            height: 16.0,
          ),
          new Text(
            "${localizations.statisticsCompletedTasks} ${_viewModel
                .completedCount}",
            style: textStyle,
          ),
        ],
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            Icons.poll,
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
