import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../i10n/app_localizations.dart';
import '../middleware/middleware.dart';
import '../model/app_state.dart';
import '../reducer/app_state_reducer.dart';
import 'app_drawer.dart';

class TodoApp extends StatelessWidget {
  final Store<AppState> store = new Store<AppState>(
    appStateReducer,
    initialState: new AppState(),
    middleware: appMiddlewares,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: new MaterialApp(
        onGenerateTitle: (context) => AppLocalizations.of(context).title,
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [const Locale('en', ''), const Locale('ja', '')],
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.redAccent,
        ),
        onGenerateRoute: drawerRoutes,
      ),
    );
  }
}
