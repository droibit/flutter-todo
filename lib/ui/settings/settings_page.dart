import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../action/action.dart';
import '../../i10n/app_localizations.dart';
import '../../model/model.dart';
import '../app_drawer.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new AppDrawer(selectedNavigation: NavigationId.settings),
      appBar: new AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: new Text(AppLocalizations.of(context).settings),
      ),
      body: new ListView(
        children: <Widget>[]..addAll(_buildAppCategory(context)),
      ),
    );
  }

  List<Widget> _buildAppCategory(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return <Widget>[
      new Container(
        constraints: new BoxConstraints(maxHeight: 48.0),
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: new Align(
            alignment: Alignment.bottomLeft,
            child: new Text(
              localizations.appCategory,
              style: new TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ]..addAll(ListTile.divideTiles(
        context: context,
        tiles: <ListTile>[
          new ListTile(
            title: new Text(localizations.sourceCodeTitle),
            subtitle: const Text('github.com'),
            onTap: () async {
              await launch(
                'https://github.com/droibit/flutter-todo',
                option: new CustomTabsOption(
                  toolbarColor: Theme.of(context).primaryColor,
                  enableDefaultShare: true,
                  enableUrlBarHiding: true,
                  showPageTitle: true,
                ),
              );
            },
          ),
          new ListTile(
            title: new Text(localizations.buildVersionTitle),
            subtitle: new StoreConnector<AppState, String>(
              distinct: true,
              onInit: (store) => store.dispatch(new GetPackageInfoAction()),
              converter: (store) =>
                  store.state.packageInfo.orNull?.version ?? "",
              builder: (context, appVersion) {
                final version = (appVersion.isNotEmpty) ? appVersion : '---';
                return new Text(
                  "${localizations.buildVersionSubtitle} $version",
                );
              },
            ),
          ),
        ],
      ));
  }
}
