import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class AppLocalizations {

  static Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  String get title => Intl.message('TO-DO', name: 'title');

  String get todoList => Intl.message('TO-DO List', name: 'todoList');

  String get statistics => Intl.message('Statistics', name: 'statistics');

  String get settings => Intl.message('Settings', name: 'settings');
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {

  const AppLocalizationsDelegate();

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => false;

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool isSupported(Locale locale) => ['en', 'ja'].contains(locale.languageCode);
}