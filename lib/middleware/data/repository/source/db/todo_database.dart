import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../config/config.dart';
import 'persistence_contract.dart';
import 'task_entity.dart';

const _dbVersion = 1;

abstract class TodoDatabase {
  Future<bool> createTask(TaskEntity entity);

  Future<List<TaskEntity>> getTasks();

  Future<bool> updateTask(String id, String title, String description);

  Future<bool> activateTask(String id);

  Future<bool> completeTask(String id);

  Future<bool> deleteTask(String id);

  Future<int> clearCompletedTask();
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
  Future<bool> createTask(TaskEntity entity) async {
    final db = await this.db;
    final insertedCount = await db.insert(TaskEntity.table, entity.toMap());
    return insertedCount > 0;
  }

  @override
  Future<List<TaskEntity>> getTasks() async {
    final db = await this.db;
    final entityMaps = await db.query(TaskEntity.table);
    return entityMaps.map((m) => new TaskEntity.fromMap(m)).toList();
  }

  @override
  Future<bool> updateTask(String id, String title, String description) async {
    final db = await this.db;
    final updateCount = await db.update(
      TaskEntity.table,
      {
        TaskEntity.columnTitle: title,
        TaskEntity.columnDescription: description
      },
      where: '${TaskEntity.columnId} = ?',
      whereArgs: [id],
    );
    return updateCount > 0;
  }

  @override
  Future<bool> activateTask(String id) async {
    final db = await this.db;
    final updateCount = await db.update(
      TaskEntity.table,
      {
        TaskEntity.columnCompleted: false,
      },
      where: "${TaskEntity.columnId} = ?",
      whereArgs: [id],
    );
    return updateCount > 0;
  }

  @override
  Future<bool> completeTask(String id) async {
    final db = await this.db;
    final updateCount = await db.update(
      TaskEntity.table,
      {
        TaskEntity.columnCompleted: true,
      },
      where: "${TaskEntity.columnId} = ?",
      whereArgs: [id],
    );
    return updateCount > 0;
  }

  @override
  Future<bool> deleteTask(String id) async {
    final db = await this.db;
    final deletedCount = await db.delete(
      TaskEntity.table,
      where: "${TaskEntity.columnId} = ?",
      whereArgs: [id],
    );
    // Successful if task has already been deleted.
    return deletedCount >= 0;
  }

  @override
  Future<int> clearCompletedTask() async {
    final db = await this.db;
    final deletedCount = await db.delete(
      TaskEntity.table,
      where: "${TaskEntity.columnCompleted} = ?",
      whereArgs: [1],
    );
    // Successful if task has already been deleted.
    return deletedCount;
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
