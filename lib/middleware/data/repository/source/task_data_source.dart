import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../../../../model/task.dart';
import 'db/task_entity.dart';
import 'db/todo_database.dart';

abstract class TaskDataSource {
  Future<Task> createTask(String title, String description);

  Future<List<Task>> getTasks();

  Future<bool> activateTask(String taskId);

  Future<bool> completeTask(String taskId);

  Future<bool> deleteTask(String taskId);
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

  @override
  Future<bool> completeTask(String taskId) async {
    final successful = await _db.completeTask(taskId);
    debugPrint("Complete: $successful, entryId: $taskId");
    return successful;
  }

  @override
  Future<bool> activateTask(String taskId) async {
    final successful = await _db.activateTask(taskId);
    debugPrint("Activate: $successful, entryId: $taskId");
    return successful;
  }

  @override
  Future<bool> deleteTask(String taskId) async {
    final successful = await _db.deleteTask(taskId);
    debugPrint("Delete: $successful, entryId: $taskId");
    return successful;
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
