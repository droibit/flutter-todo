import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

abstract class UserSettingsDataSource {
  Future<int> getTasksSortByIndex();

  Future<int> getTasksSortByOrderIndex();

  Future<bool> setTasksSortByIndex(int sortByIndex, int orderIndex);
}

const _keySortByIndex = "sortByIndex";
const _keySortByOrderIndex = "sortByOrderIndex";

class LocalUserSettingsDataSource implements UserSettingsDataSource {
  SharedPreferences _sharedPrefs;

  Future<SharedPreferences> get sharedPrefs async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
    return _sharedPrefs;
  }

  @override
  Future<int> getTasksSortByIndex() async {
    final sharedPrefs = await this.sharedPrefs;
    return sharedPrefs.getInt(_keySortByIndex);
  }

  @override
  Future<int> getTasksSortByOrderIndex() async {
    final sharedPrefs = await this.sharedPrefs;
    return sharedPrefs.getInt(_keySortByOrderIndex);
  }

  @override
  Future<bool> setTasksSortByIndex(int sortByIndex, int orderIndex) async {
    final sharedPrefs = await this.sharedPrefs;
    final List<bool> results = await Future.wait([
      sharedPrefs.setInt(_keySortByIndex, sortByIndex),
      sharedPrefs.setInt(_keySortByOrderIndex, orderIndex)
    ]);
    final containsFailed = results.any((successful) => !successful);
    return !containsFailed;
  }
}
