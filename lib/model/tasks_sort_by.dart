import 'package:flutter/foundation.dart';

enum SortBy { title, created_date }

enum Order { asc, desc }

@immutable
class TasksSortBy {
  final SortBy sortBy;

  final Order order;

  const TasksSortBy({
    @required this.sortBy,
    @required this.order,
  })  : assert(sortBy != null),
        assert(order != null);

  TasksSortBy reverseOrder() {
    return new TasksSortBy(
      sortBy: sortBy,
      order: order == Order.asc ? Order.desc : Order.asc,
    );
  }

  TasksSortBy copyWith({
    SortBy sortBy,
    Order order,
  }) {
    return new TasksSortBy(
      sortBy: sortBy ?? this.sortBy,
      order: order ?? this.order,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TasksSortBy &&
          runtimeType == other.runtimeType &&
          sortBy == other.sortBy &&
          order == other.order;

  @override
  int get hashCode => sortBy.hashCode ^ order.hashCode;

  @override
  String toString() {
    return 'TasksSortBy{sortBy: $sortBy, order: $order}';
  }
}
