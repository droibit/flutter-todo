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

  final TasksSortBy tasksSortBy;

  final Optional<EditTask> editTask;

  final Optional<PackageInfo> packageInfo;

  const AppState({
    this.tasks = const [],
    this.tasksFilter = TasksFilter.all,
    this.tasksSortBy =
        const TasksSortBy(sortBy: SortBy.created_date, order: Order.asc),
    this.editTask = const Optional.absent(),
    this.packageInfo = const Optional.absent(),
  });

  AppState copyWith({
    List<Task> tasks,
    TasksFilter tasksFilter,
    TasksSortBy tasksSortBy,
    Optional<EditTask> editTask,
    Optional<PackageInfo> packageInfo,
  }) {
    return new AppState(
      tasks: tasks ?? this.tasks,
      tasksFilter: tasksFilter ?? this.tasksFilter,
      tasksSortBy: tasksSortBy ?? this.tasksSortBy,
      editTask: editTask ?? this.editTask,
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
          editTask == other.editTask &&
          packageInfo == other.packageInfo;

  @override
  int get hashCode =>
      tasks.hashCode ^
      tasksFilter.hashCode ^
      tasksSortBy.hashCode ^
      editTask.hashCode ^
      packageInfo.hashCode;

  @override
  String toString() {
    return 'AppState{tasks: $tasks, tasksFilter: $tasksFilter, tasksSortBy: $tasksSortBy, editTask: $editTask, packageInfo: $packageInfo}';
  }
}
