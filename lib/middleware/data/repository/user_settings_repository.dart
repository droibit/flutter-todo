import 'dart:async';

import '../../../model/tasks_sort_by.dart';
import 'source/user_settings_data_source.dart';

// TODO: Error handling.
abstract class UserSettingsRepository {
  Future<TasksSortBy> loadTasksSortBy();

  Future<void> storeTasksSortBy(TasksSortBy tasksSortBy);
}

const _defaultTasksSortBy = const TasksSortBy(
  sortBy: SortBy.created_date,
  order: Order.asc,
);

class UserSettingsRepositoryImpl implements UserSettingsRepository {
  UserSettingsDataSource _dataSource;

  UserSettingsRepositoryImpl(this._dataSource) : assert(_dataSource != null);

  @override
  Future<void> storeTasksSortBy(TasksSortBy tasksSortBy) async {
    await _dataSource.setTasksSortByIndex(
        tasksSortBy.sortBy.index, tasksSortBy.order.index);
  }

  @override
  Future<TasksSortBy> loadTasksSortBy() async {
    final indices = await Future.wait([
      _dataSource.getTasksSortByIndex(),
      _dataSource.getTasksSortByOrderIndex()
    ]);
    if (indices.any((i) => i == null)) {
      return null;
    }
    return new TasksSortBy(
      sortBy: SortBy.values[indices[0]],
      order: Order.values[indices[1]],
    );
  }
}
