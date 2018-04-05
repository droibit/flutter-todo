import 'dart:async';

import '../../model/task.dart';
import 'source/task_data_source.dart';

abstract class TaskRepository {
  Future<Task> createTask(String title, String description);
}

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _dataSource;

  final Map<String, Task> _cache = {};

  TaskRepositoryImpl(this._dataSource);

  @override
  Future<Task> createTask(String title, String description) {
    assert(title != null);

    return _dataSource.createTask(title, description).then((task) {
      _cache[task.id] = task;
      return task;
    });
    // .catchError((error) => ...);
  }
}
