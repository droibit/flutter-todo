import 'dart:async';

import 'package:sqflite/sqflite.dart';

abstract class PersistenceContract {
  Future onCreate(Database db);

  Future onUpgrade(Database db, int oldVersion, int newVersion);
}
