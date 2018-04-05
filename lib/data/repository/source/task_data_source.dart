import 'dart:async';

import 'package:uuid/uuid.dart';

import '../../../model/task.dart';
import 'db/task_entity.dart';
import 'db/todo_database.dart';

abstract class TaskDataSource {
  Future<Task> createTask(String title, String description);
}

class LocalTaskDataSource implements TaskDataSource {
  final TodoDatabase _db;

  final Uuid uuid = new Uuid();

  LocalTaskDataSource(this._db);

  @override
  Future<Task> createTask(String title, String description) {
    final entity = new TaskEntity(
      id: uuid.v4(),
      title: title,
      description: description ?? "",
      timestamp: DateTime.now().millisecondsSinceEpoch,
      completed: false,
    );
    return _db.createTask(entity).then((e) {
      return new Task(
        id: e.id,
        title: e.title,
        timestamp: new DateTime.fromMillisecondsSinceEpoch(e.timestamp),
        completed: e.completed,
      );
    });
  }
}
