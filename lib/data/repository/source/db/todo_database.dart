import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import 'persistence_contract.dart';
import 'todo_entity.dart';

const _dbVersion = 1;

class TodoDatabase {

  static final _contracts = <PersistenceContract>[
    TodoEntity.contract,
  ];

  final String _dbPath;

  Database _db;

  TodoDatabase(this._dbPath)
    : assert(_dbPath?.isNotEmpty);

  void open() async {

    _db = await openDatabase(_dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: (db) {
        debugPrint("#onOpen()");
      }
    );
  }

  Future _onCreate(Database db, int newVersion) async {
    debugPrint("#onCreate(newVersion=$newVersion)");

    for (var contract in _contracts) {
      await contract.onCreate(db);
    }
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    for (var contract in _contracts) {
      await contract.onUpgrade(db, oldVersion, newVersion);
    }
  }
}