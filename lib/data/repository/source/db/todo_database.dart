import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../config/config.dart';
import 'persistence_contract.dart';
import 'task_entity.dart';

const _dbVersion = 1;

abstract class TodoDatabase {

  Future<TaskEntity> createTask(TaskEntity entity);
}

class TodoDatabaseImpl implements TodoDatabase {

  static final _contracts = <PersistenceContract>[
    TaskEntity.contract,
  ];

  Database _db;

  // FIXME: thread safe...?
  Future<Database> get db async {
    if (_db == null) {
      _db = await _open();
    }
    return _db;
  }

  Future<Database> _open() async {
    final dbName = await DbConfig.getTodoDbPath();
    return await openDatabase(dbName,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: (db) {
        debugPrint("#onOpen()");
      }
    );
  }


  @override
  Future<TaskEntity> createTask(TaskEntity entity) async {
    final db = await this.db;
    final inserted = await db.insert(TaskEntity.table, entity.toMap());
    assert(inserted > 0);
    return Future.value(entity);
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