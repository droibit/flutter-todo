import 'dart:async';

import '../../../model/task.dart';
import 'source/task_data_source.dart';

// TODO: Error handling.
abstract class TaskRepository {
  Future<Task> createTask(String title, String description);

  Future<List<Task>> getTasks();

  Future<void> activateTask(String taskId);

  Future<void> completeTask(String taskId);

  Future<void> deleteTask(String taskId);

  Future<void> clearCompletedTasks();
}

class TaskRepositoryImpl implements TaskRepository {
  final TaskDataSource _dataSource;

  TaskRepositoryImpl(this._dataSource) : assert(_dataSource != null);

  @override
  Future<Task> createTask(String title, String description) async {
    assert(title != null);

    return await _dataSource.createTask(title, description);
    // .catchError((error) => ...);
  }

  @override
  Future<List<Task>> getTasks() async {
    final tasks = await _dataSource.getTasks();
    return new List.unmodifiable(tasks);
  }

  @override
  Future<void> activateTask(String taskId) async {
    assert(taskId != null);
    await _dataSource.activateTask(taskId);
  }

  @override
  Future<void> completeTask(String taskId) async {
    assert(taskId != null);
    await _dataSource.completeTask(taskId);
  }

  @override
  Future<void> deleteTask(String taskId) async {
    assert(taskId != null);
    await _dataSource.deleteTask(taskId);
  }

  @override
  Future<void> clearCompletedTasks() async {
    await _dataSource.clearCompletedTasks();
  }
}
