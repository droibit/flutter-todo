import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../config/config.dart';
import 'persistence_contract.dart';
import 'task_entity.dart';

const _dbVersion = 1;

abstract class TodoDatabase {
  Future<TaskEntity> createTask(TaskEntity entity);

  Future<List<TaskEntity>> getTasks();
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
    return await openDatabase(
      dbName,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onOpen: (db) {
        debugPrint("#onOpen()");
      },
    );
  }

  @override
  Future<TaskEntity> createTask(TaskEntity entity) async {
    return db
        .then((db) => db.insert(TaskEntity.table, entity.toMap()))
        .then((count) {
      assert(count > 0);
      return entity;
    });
  }

  @override
  Future<List<TaskEntity>> getTasks() async {
    return db.then((db) => db.query(TaskEntity.table)).then((result) {
      return result.map((m) => new TaskEntity.fromMap(m)).toList();
    });
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
