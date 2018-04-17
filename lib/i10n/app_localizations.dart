import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
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

  String get noTasks => Intl.message('No TO-DOs.', name: 'noTasks');

  String get todoListHeaderAll => Intl.message('All TO-DOs', name: 'todoListHeaderAll');

  String get todoListHeaderActive => Intl.message('Active TO-DOs', name: 'todoListHeaderActive');

  String get todoListHeaderCompleted => Intl.message('Completed TO-DOs', name: 'todoListHeaderCompleted');

  String get todoListFilterAll => Intl.message('All', name: 'todoListFilterAll');

  String get todoListFilterActive => Intl.message('Active', name: 'todoListFilterActive');

  String get todoListFilterCompleted => Intl.message('Completed', name: 'todoListFilterCompleted');

  String get todoListSortBy => Intl.message('Sort by', name: 'todoListSortBy');

  String get todoListClearCompleted => Intl.message('Clear completed', name: 'todoListClearCompleted');

  String get todoListSortByTitle => Intl.message('Title', name: 'todoListSortByTitle');

  String get todoListSortByCreatedDate => Intl.message('Created Date', name: 'todoListSortByCreatedDate');

  String get newTask => Intl.message('New TO-DO', name: 'newTask');

  String get newTaskTitleLabel => Intl.message('Title', name: 'newTaskTitleLabel');
  
  String get newTaskTitleValidationError => Intl.message('Title is required.', name: 'newTaskTitleValidationError');

  String get newTaskDescLabel => Intl.message('Description', name: 'newTaskDescLabel');

  String get newTaskDescHint => Intl.message('Enter your TO-DO here.', name: 'newTaskDescHint');

  String get newTaskFailedToCreate => Intl.message('Failed to create new TO-DO.', name: 'newTaskFailedToCreate');

  String get newTaskSuccessfulToCreate => Intl.message('TO-DO created.', name: 'newTaskSuccessfulToCreate');

  String get statistics => Intl.message('Statistics', name: 'statistics');

  String get statisticsActiveTasks => Intl.message('Active TO-DOs:', name: 'statisticsActiveTasks');

  String get statisticsCompletedTasks => Intl.message('Completed TO-DOs:', name: 'statisticsCompletedTasks');

  String get settings => Intl.message('Settings', name: 'settings');

  String get appCategory => Intl.message('App', name: 'appCategory');

  String get buildVersionTitle =>
      Intl.message('Build version', name: 'buildVersionTitle');

  String get buildVersionSubtitle =>
      Intl.message('Version: ', name: 'buildVersionSubtitle');
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
