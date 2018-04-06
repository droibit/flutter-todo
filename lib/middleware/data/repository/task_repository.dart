import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../model/task.dart';
import 'source/task_data_source.dart';

abstract class TaskRepository {
  Future<Task> createTask(String title, String description);

  Future<List<Task>> getTasks();

  void refreshTask();
}

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _dataSource;

  final Map<String, Task> _cache = {};

  bool _cacheIsDirty = false;

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

  @override
  Future<List<Task>> getTasks() async {
    if (_cache.isNotEmpty && !_cacheIsDirty) {
      return new List.unmodifiable(_cache.values);
    }

    final tasks = await _dataSource.getTasks();
    _refreshCache(tasks);
    return new List.unmodifiable(tasks);
  }

  @override
  void refreshTask() {
    _cacheIsDirty = true;
  }

  void _refreshCache(List<Task> tasks) {
    _cache.clear();
    tasks.forEach((t) => _cache[t.id] = t);
    debugPrint("Cached tasks: $tasks");

    _cacheIsDirty = false;
  }
}
