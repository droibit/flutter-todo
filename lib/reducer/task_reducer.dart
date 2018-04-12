import 'package:redux/redux.dart';

import '../action/task_action.dart';
import '../model/model.dart';

final tasksReducer = combineReducers<List<Task>>([
  new TypedReducer<List<Task>, OnGetTaskAction>(_getTasks),
  new TypedReducer<List<Task>, OnCreateTaskAction>(_createNewTasks),
  new TypedReducer<List<Task>, UpdateTaskAction>(_updateTasks)
]);

List<Task> _getTasks(List<Task> state, OnGetTaskAction action) {
  return action.tasks;
}

List<Task> _createNewTasks(List<Task> state, OnCreateTaskAction action) {
  final createTask = action.createTask;
  if (createTask?.isSuccessful == true) {
    return new List.of(state)..add(createTask.task);
  }
  return state;
}

List<Task> _updateTasks(List<Task> state, UpdateTaskAction action) {
  final updatedTask = action.task;
  return state
      .map((task) => task.id == updatedTask.id ? updatedTask : task)
      .toList(growable: false);
}
