import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../i10n/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  final NavigationId selectedNavigation;

  final ValueChanged<NavigationId> onNavigationSelect;

  AppDrawer(
      {Key key,
      @required this.selectedNavigation,
      @required this.onNavigationSelect})
      : super(key: key);

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
          id: NavigationId.todoList,
          icon: Icons.list,
          title: localizations.todoList),
      new _NavigationItem(
          id: NavigationId.statistics,
          icon: Icons.poll,
          title: localizations.statistics),
    ];

    return navItems
        .map((navItem) => _buildNavigationListTile(navItem))
        .toList();
  }

  List<Widget> _buildFooter(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final navItems = <_NavigationItem>[
      new _NavigationItem(
          id: NavigationId.settings,
          icon: Icons.settings,
          title: localizations.settings),
    ];
    return navItems
        .map((navItem) => _buildNavigationListTile(navItem))
        .toList();
  }

  ListTile _buildNavigationListTile(_NavigationItem navItem) {
    return new ListTile(
      leading: new Icon(navItem.icon),
      title: new Text(navItem.title),
      selected: navItem.id == selectedNavigation,
      onTap: () => onNavigationSelect(navItem.id),
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

enum NavigationId { todoList, statistics, settings }

class _NavigationItem {
  final NavigationId id;

  final IconData icon;

  final String title;

  _NavigationItem(
      {@required this.id, @required this.icon, @required this.title});
}
