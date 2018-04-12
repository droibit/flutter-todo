import 'package:redux/redux.dart';

import '../action/tasks_filter_action.dart';
import '../model/tasks_filter.dart';

final tasksFilterReducer = combineReducers<TasksFilter>([
  new TypedReducer<TasksFilter, ChangeTasksFilterAction>(_changeTaskFilter),
]);

TasksFilter _changeTaskFilter(
    TasksFilter state, ChangeTasksFilterAction action) {
  return action.filter;
}
