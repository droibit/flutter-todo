import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'persistence_contract.dart';

const _tableName = "task";
const _id = "entry_id";
const _title = "title";
const _description = "description";
const _timestamp = "timestamp";
const _completed = "completed";

const _createSqlV1 = """
CREATE TABLE $_tableName (
 $_id TEXT PRIMARY KEY,
 $_title TEXT NOT NULL,
 $_description TEXT NOT NULL,
 $_timestamp INTEGER NOT NULL,
 $_completed INTEGER NOT NULL
);
""";

class _TaskPersistenceContract implements PersistenceContract {
  @override
  Future onCreate(Database db) async {
    await db.execute(_createSqlV1);
  }

  @override
  Future onUpgrade(Database db, int oldVersion, int newVersion) => null;
}

class TaskEntity {
  static final contract = _TaskPersistenceContract();

  static const table = _tableName;

  static const columnTimestamp = _timestamp;

  static const columnTitle = _title;

  final String id;

  final String title;

  final String description;

  final int timestamp;

  final bool completed;

  TaskEntity(
      {this.id, this.title, this.description, this.timestamp, this.completed})
      : assert(title?.isNotEmpty),
        assert(description?.isNotEmpty),
        assert(timestamp != null);

  factory TaskEntity.fromMap(Map<String, dynamic> values) =>
      _taskEntityFromMap(values);

  Map<String, dynamic> toMap() => {
        _id: id,
        _title: title,
        _description: description,
        _timestamp: timestamp,
        _completed: completed ? 1 : 0,
      };

  @override
  String toString() {
    return 'TaskEntity{id: $id, title: $title, description: $description, timestamp: $timestamp, completed: $completed}';
  }
}

TaskEntity _taskEntityFromMap(Map<String, dynamic> values) => new TaskEntity(
      id: values[_id] as String,
      title: values[_title] as String,
      description: values[_description] as String,
      timestamp: values[_timestamp] as int,
      completed: (values[_completed] as int) == 1,
    );
