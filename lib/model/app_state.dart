import 'package:flutter/foundation.dart';

import 'package_info.dart';
import 'task.dart';
import '../uitls/optional.dart';

@immutable
class AppState {
  final List<Task> tasks;

  final TasksFilter tasksFilter;

  final Optional<CreateTask> createTask;

  final Optional<PackageInfo> packageInfo;

  const AppState({
    this.tasks = const [],
    this.tasksFilter = TasksFilter.all,
    this.createTask = const Optional.absent(),
    this.packageInfo = const Optional.absent(),
  });

  AppState copyWith({
    List<Task> tasks,
    TasksFilter tasksFilter,
    CreateTask createTask,
    PackageInfo packageInfo,
  }) {
    // FIXME: Null does not overwrite the field.
    return new AppState(
      tasks: tasks ?? this.tasks,
      tasksFilter: tasksFilter ?? this.tasksFilter,
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
              createTask == other.createTask &&
              packageInfo == other.packageInfo;

  @override
  int get hashCode =>
      tasks.hashCode ^
      tasksFilter.hashCode ^
      createTask.hashCode ^
      packageInfo.hashCode;

  @override
  String toString() {
    return 'AppState{tasks: $tasks, tasksFilter: $tasksFilter, createTask: $createTask, packageInfo: $packageInfo}';
  }
}
