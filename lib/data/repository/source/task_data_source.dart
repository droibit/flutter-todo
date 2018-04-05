import 'dart:async';

import 'package:uuid/uuid.dart';

import '../../../model/task.dart';
import 'db/task_entity.dart';
import 'db/todo_database.dart';

abstract class TaskDataSource {
  Future<Task> createTask(String title, String description);
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
  Future<Task> createTask(String title, String description) {
    final entity = new TaskEntity(
      id: _uuid.v4(),
      title: title,
      description: description ?? "",
      timestamp: DateTime.now().millisecondsSinceEpoch,
      completed: false,
    );
    return _db.createTask(entity).then((e) => convertToModel(e));
  }
}

class _TaskConverter {
  Task convertToModel(TaskEntity entity) {
    return new Task(
      id: entity.id,
      title: entity.title,
      timestamp: new DateTime.fromMillisecondsSinceEpoch(entity.timestamp),
      completed: entity.completed,
    );
  }
}
