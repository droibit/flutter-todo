import 'package:flutter/foundation.dart';

import 'package_info.dart';
import 'task.dart';

@immutable
class AppState {
  final List<Task> tasks;

  final CreateTask createTask;

  final PackageInfo packageInfo;

  const AppState({
    this.tasks = const [],
    this.createTask,
    this.packageInfo,
  });

  AppState copy({
    List<Task> tasks,
    CreateTask createTask,
    PackageInfo packageInfo,
  }) {
    return new AppState(
      tasks: tasks ?? this.tasks,
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
          createTask == other.createTask &&
          packageInfo == other.packageInfo;

  @override
  int get hashCode =>
      tasks.hashCode ^ createTask?.hashCode ^ packageInfo?.hashCode;

  @override
  String toString() {
    return 'AppState{tasks: $tasks, createTask: $createTask, packageInfo: $packageInfo}';
  }
}
