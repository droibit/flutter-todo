import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'persistence_contract.dart';

const _tableName = "todo";
const _id = "entry_id";
const _title = "title";
const _description = "description";
const _timestamp = "timestamp";
const _completed = "completed";

const _createSqlV1 = """
CREATE TABLE $_tableName (
 $_id INTEGER PRIMARY KEY,
 $_title TEXT NOT NULL,
 $_description TEXT NOT NULL,
 $_timestamp INTEGER NOT NULL,
 $_completed INTEGER NOT NULL
);
""";

class _TodoPersistenceContract implements PersistenceContract {

  @override
  Future onCreate(Database db) async {
    await db.execute(_createSqlV1);
  }

  @override
  Future onUpgrade(Database db, int oldVersion, int newVersion) => null;
}

class TodoEntity {

  static final contract = _TodoPersistenceContract();

  final int id;

  final String title;

  final String description;

  final DateTime timestamp;

  final bool completed;

  TodoEntity({this.id, this.title, this.description, this.timestamp, this.completed})
    : assert(title?.isNotEmpty),
      assert(description?.isNotEmpty),
      assert(timestamp != null);

  factory TodoEntity.fromMap(Map<String, dynamic> values) => _todoEntityFromMap(values);

  Map<String, dynamic> toMap() => {
    _id: id,
    _title: title,
    _description: description,
    _timestamp: timestamp.millisecondsSinceEpoch,
    _completed: completed ? 1 : 0,
  };
}

TodoEntity _todoEntityFromMap(Map<String, dynamic> values) => new TodoEntity(
  id: values[_id] as int,
  title: values[_title] as String,
  description: values[_description] as String,
  timestamp: new DateTime.fromMillisecondsSinceEpoch(values[_timestamp] as int),
  completed: (values[_completed] as int) == 1,
);