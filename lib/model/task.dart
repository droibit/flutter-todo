import 'package:flutter/foundation.dart';

@immutable
class Task {
  final String id;

  final String title;

  final String description;

  final DateTime timestamp;

  final bool completed;

  bool get isActive => !completed;

  const Task({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.timestamp,
    @required this.completed,
  })  : assert(id != null),
        assert(title != null),
        assert(description != null),
        assert(timestamp != null),
        assert(completed != null);

  Task copy({
    String id,
    String title,
    String description,
    DateTime timestamp,
    bool completed,
  }) {
    return new Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      completed: completed ?? this.completed,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          timestamp == other.timestamp &&
          completed == other.completed;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      timestamp.hashCode ^
      completed.hashCode;

  @override
  String toString() {
    return 'Task{id: $id, title: $title, description: $description, timestamp: $timestamp, completed: $completed}';
  }
}

@immutable
class EditTask {
  final Task task;

  final bool isNew;

  // Add an error if need.

  bool get isSuccessful => task != null;

  const EditTask.success(
    this.task, {
    @required this.isNew,
  })  : assert(task != null),
        assert(isNew != null);

  const EditTask.error()
      : task = null,
        isNew = null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EditTask &&
          runtimeType == other.runtimeType &&
          task == other.task &&
          isNew == other.isNew;

  @override
  int get hashCode => task.hashCode ^ isNew.hashCode;

  @override
  String toString() {
    return 'EditTask{task: $task, isNew: $isNew}';
  }
}
