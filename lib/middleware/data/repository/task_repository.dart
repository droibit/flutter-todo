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

  final _cache = new Map<String, Task>();

  bool _cacheIsDirty = false;

  TaskRepositoryImpl(this._dataSource);

  @override
  Future<Task> createTask(String title, String description) async {
    assert(title != null);

    final newTask = await _dataSource.createTask(title, description);
    _cache[newTask.id] = newTask;
    return newTask;
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
