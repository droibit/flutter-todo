import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../i10n/app_localizations.dart';
import 'routes.dart';
import 'settings/settings_page.dart';
import 'statistics/statistics_page.dart';
import 'tasks/tasks_page.dart';

enum NavigationId { tasks, statistics, settings }

class _NavigationItem {
  final NavigationId id;

  final IconData icon;

  final String title;

  _NavigationItem({
    @required this.id,
    @required this.icon,
    @required this.title,
  });
}

final RouteFactory drawerRoutes = (settings) {
  print("RouteFactory(settings=${settings.name}");
  switch (settings.name) {
    case '/':
      return new FadePageRoute(
        builder: (context) => new TasksPage(),
        settings: settings,
      );
    case '/tasks':
      return new FadePageRoute(
        builder: (context) => new TasksPage(),
        settings: settings,
      );
    case '/statistics':
      return new MaterialPageRoute(
        builder: (context) => new StatisticsPage(),
        settings: settings,
      );
    case '/settings':
      return new MaterialPageRoute(
        builder: (context) => new SettingsPage(),
        settings: settings,
      );
  }
};

class _AppDrawerNavigator {
  final NavigationId currentNavId;

  const _AppDrawerNavigator({
    @required NavigationId initialValue,
  })  : assert(initialValue != null),
        currentNavId = initialValue;

  void open(BuildContext context, NavigationId navId) {
    print("#onNavigationSelect($navId, current=$currentNavId)");
    // Hide drawer.
    Navigator.pop(context);

    if (currentNavId == navId) {
      return;
    }
    switch (navId) {
      case NavigationId.tasks:
        Navigator.pop(context);
        break;
      case NavigationId.statistics:
        Navigator.pushNamed(context, '/statistics');
        break;
      case NavigationId.settings:
        Navigator.pushNamed(context, '/settings');
        break;
    }
  }
}

class AppDrawer extends StatelessWidget {
  final _AppDrawerNavigator _navigator;

  AppDrawer({
    @required NavigationId selectedNavigation,
    Key key,
  })  : assert(selectedNavigation != null),
        _navigator = new _AppDrawerNavigator(initialValue: selectedNavigation),
        super(key: key);

  Widget _buildHeader(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return new DrawerHeader(
      child: Row(
        children: <Widget>[
          new Container(
            child: new Image.asset(
              'assets/drawer_header_icon.png',
              width: 80.0,
              height: 80.0,
            ),
            padding: const EdgeInsets.only(right: 16.0),
          ),
          new Text(
            localizations.title,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          )
        ],
      ),
      decoration: new BoxDecoration(color: Colors.blueGrey[200]),
    );
  }

  List<ListTile> _buildNavItems(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final navItems = <_NavigationItem>[
      new _NavigationItem(
        id: NavigationId.tasks,
        icon: Icons.list,
        title: localizations.todoList,
      ),
      new _NavigationItem(
        id: NavigationId.statistics,
        icon: Icons.poll,
        title: localizations.statistics,
      ),
    ];

    return navItems
        .map((navItem) => _buildNavigationListTile(context, navItem))
        .toList();
  }

  List<Widget> _buildFooter(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final navItems = <_NavigationItem>[
      new _NavigationItem(
        id: NavigationId.settings,
        icon: Icons.settings,
        title: localizations.settings,
      ),
    ];
    return navItems
        .map((navItem) => _buildNavigationListTile(context, navItem))
        .toList();
  }

  ListTile _buildNavigationListTile(
      BuildContext context, _NavigationItem navItem) {
    return new ListTile(
      leading: new Icon(navItem.icon),
      title: new Text(navItem.title),
      selected: navItem.id == _navigator.currentNavId,
      onTap: () => _navigator.open(context, navItem.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final children = List<Widget>()
      ..add(_buildHeader(context))
      ..addAll(_buildNavItems(context))
      ..add(new Divider())
      ..addAll(_buildFooter(context));
    return new Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,
        children: children,
      ),
    );
  }
}
