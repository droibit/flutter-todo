import 'package:flutter/foundation.dart';

import 'package_info.dart';
import 'task.dart';

@immutable
class AppState {
  final List<Task> tasks;

  final PackageInfo packageInfo;

  const AppState({
    this.tasks = const [],
    this.packageInfo = const PackageInfo(),
  });

  AppState copy({List<Task> tasks, PackageInfo packageInfo}) {
    return new AppState(
      tasks: tasks ?? this.tasks,
      packageInfo: packageInfo ?? this.packageInfo,
    );
  }


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              tasks == other.tasks &&
              packageInfo == other.packageInfo;

  @override
  int get hashCode =>
      tasks.hashCode ^
      packageInfo.hashCode;

  @override
  String toString() {
    return 'AppState{tasks: $tasks, packageInfo: $packageInfo}';
  }
}
