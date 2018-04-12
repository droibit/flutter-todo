import 'package:flutter/foundation.dart';

import '../uitls/optional.dart';
import 'package_info.dart';
import 'task.dart';
import 'tasks_filter.dart';
import 'tasks_sort_by.dart';

@immutable
class AppState {
  final List<Task> tasks;

  final TasksFilter tasksFilter;

  final Optional<TasksSortBy> tasksSortBy;

  final Optional<CreateTask> createTask;

  final Optional<PackageInfo> packageInfo;

  const AppState({
    this.tasks = const [],
    this.tasksFilter = TasksFilter.all,
    this.tasksSortBy = const Optional.absent(),
    this.createTask = const Optional.absent(),
    this.packageInfo = const Optional.absent(),
  });

  AppState copyWith({
    List<Task> tasks,
    TasksFilter tasksFilter,
    Optional<TasksSortBy> tasksSortBy,
    Optional<CreateTask> createTask,
    Optional<PackageInfo> packageInfo,
  }) {
    // FIXME: Null does not overwrite the field.
    return new AppState(
      tasks: tasks ?? this.tasks,
      tasksFilter: tasksFilter ?? this.tasksFilter,
      tasksSortBy: tasksSortBy ?? this.tasksSortBy,
      createTask: createTask ?? this.createTask,
      packageInfo: packageInfo ?? this.packageInfo,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          tasks == other.tasks &&
          tasksFilter == other.tasksFilter &&
          tasksSortBy == other.tasksSortBy &&
          createTask == other.createTask &&
          packageInfo == other.packageInfo;

  @override
  int get hashCode =>
      tasks.hashCode ^
      tasksFilter.hashCode ^
      tasksSortBy.hashCode ^
      createTask.hashCode ^
      packageInfo.hashCode;

  @override
  String toString() {
    return 'AppState{tasks: $tasks, tasksFilter: $tasksFilter, tasksSortBy: $tasksSortBy, createTask: $createTask, packageInfo: $packageInfo}';
  }
}
