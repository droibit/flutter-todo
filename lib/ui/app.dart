import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_drawer.dart';
import 'tasks/tasks_page.dart';
import '../i10n/app_localizations.dart';

class TodoApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    );
  }
}