import 'package:redux/redux.dart';

import '../action/task_action.dart';
import '../action/tasks_sort_by_action.dart';
import '../model/tasks_sort_by.dart';
import '../uitls/optional.dart';

final tasksSortByReducer = combineReducers<Optional<TasksSortBy>>([
  new TypedReducer<Optional<TasksSortBy>, OnGetTaskAction>(
    _getTasks
  ),
  new TypedReducer<Optional<TasksSortBy>, ChangeTasksSortByAction>(
    _tasksSortBy,
  ),
]);

Optional<TasksSortBy> _getTasks(
    Optional<TasksSortBy> state, OnGetTaskAction action) {
  return new Optional.of(action.tasksSortBy);
}

Optional<TasksSortBy> _tasksSortBy(
    Optional<TasksSortBy> state, ChangeTasksSortByAction action) {
  return new Optional.of(action.tasksSortBy);
}
