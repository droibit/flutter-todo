
class Todo {

  final int id;

  final String title;

  final String description;

  final DateTime timestamp;

  final bool completed;

  Todo({this.id, this.title, this.description, this.timestamp, this.completed});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Todo &&
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
    return 'Todo{id: $id, title: $title, description: $description, timestamp: $timestamp, completed: $completed}';
  }
}