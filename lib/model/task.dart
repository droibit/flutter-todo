
class Task {

  final int id;

  final String title;

  final String description;

  final DateTime timestamp;

  final bool completed;

  bool get isActive => !completed;

  Task({this.id, this.title, this.description, this.timestamp, this.completed});

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