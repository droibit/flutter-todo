import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import '../../i10n/app_localizations.dart';
import '../app_drawer.dart';
import 'settings_store.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  State createState() => new SettingsPageState();
}

class SettingsPageState extends State<SettingsPage>
    with StoreWatcherMixin<SettingsPage> {
  SettingsStore _settingsStore;

  @override
  void initState() {
    super.initState();
    _settingsStore = listenToStore(settingsStoreToken);
    getPackageAction();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
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
        children: <Widget>[
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
          new ListTile(
            title: new Text(localizations.buildVersionTitle),
            subtitle: new Text(
              "${localizations.buildVersionSubtitle} ${_settingsStore.appVersion ?? '---'}",
            ),
          ),
        ],
      ),
    );
  }
}
