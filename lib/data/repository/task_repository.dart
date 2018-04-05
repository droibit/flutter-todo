import 'dart:async';

import '../../model/task.dart';
import 'source/task_data_source.dart';

abstract class TaskRepository {
  Future<Task> createTask(String title, String description);
}

class TaskRepositoryImpl implements TaskRepository {
  TaskDataSource _dataSource;

  TaskRepositoryImpl(this._dataSource);

  @override
  Future<Task> createTask(String title, String description) {
    assert(title != null);

    return _dataSource.createTask(title, description).then((task) {
      // TODO: cache task.
      return task;
    });
  }
}
