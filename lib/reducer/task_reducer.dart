import 'package:redux/redux.dart';

import '../action/task_action.dart';
import '../model/task.dart';

final tasksReducer = combineReducers<List<Task>>([
  new TypedReducer<List<Task>, OnGetTaskAction>(_getTasks),
]);

List<Task> _getTasks(List<Task> state, OnGetTaskAction action) {
  return action.tasks;
}

final createTaskReducer = combineReducers<CreateTask>([
  new TypedReducer<CreateTask, OnCreateTaskAction>(_createTask),
  new TypedReducer<CreateTask, CreateTaskResetAction>(_resetCreateTask)
]);

CreateTask _createTask(CreateTask state, OnCreateTaskAction action) {
  return action.createTask;
}

CreateTask _resetCreateTask(CreateTask state, CreateTaskResetAction action) {
  return null;
}