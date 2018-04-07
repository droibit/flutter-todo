import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../../model/task.dart';
import 'db/task_entity.dart';
import 'db/todo_database.dart';

abstract class TaskDataSource {
  Future<Task> createTask(String title, String description);

  Future<List<Task>> getTasks();
}

class LocalTaskDataSource extends Object
    with _TaskConverter
    implements TaskDataSource {
  final TodoDatabase _db;

  final Uuid _uuid = new Uuid();

  LocalTaskDataSource(
    this._db,
  );

  @override
  Future<Task> createTask(String title, String description) async {
    final entity = new TaskEntity(
      id: _uuid.v4(),
      title: title,
      description: description ?? "",
      timestamp: DateTime.now().millisecondsSinceEpoch,
      completed: false,
    );

    // TODO: error handling
    final successful = await _db.createTask(entity);
    debugPrint("Create: $successful, entity: $entity");

    return convertToModel(entity);
  }

  @override
  Future<List<Task>> getTasks() async {
    final entities = await _db.getTasks();
    final tasks = entities.map(convertToModel);
    return new List.unmodifiable(tasks);
  }
}

class _TaskConverter {
  Task convertToModel(TaskEntity entity) {
    return new Task(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      timestamp: new DateTime.fromMillisecondsSinceEpoch(entity.timestamp),
      completed: entity.completed,
    );
  }
}
