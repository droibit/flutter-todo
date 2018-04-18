import 'package:redux/redux.dart';

import '../action/task_action.dart';
import '../action/tasks_sort_by_action.dart';
import '../model/tasks_sort_by.dart';

final tasksSortByReducer = combineReducers<TasksSortBy>([
  new TypedReducer<TasksSortBy, OnGetTaskAction>(
    _getTasksSortBy,
  ),
  new TypedReducer<TasksSortBy, ChangeTasksSortByAction>(
    _changeTasksSortBy,
  ),
]);

TasksSortBy _getTasksSortBy(TasksSortBy state, OnGetTaskAction action) {
  if (action.tasksSortBy == null) {
    return state;
  }
  return action.tasksSortBy;
}

TasksSortBy _changeTasksSortBy(
    TasksSortBy state, ChangeTasksSortByAction action) {
  return action.tasksSortBy;
}
