import 'package:redux/redux.dart';

import '../action/task_action.dart';
import '../model/model.dart';

final tasksReducer = combineReducers<List<Task>>([
  new TypedReducer<List<Task>, OnGetTaskAction>(_getTasks),
  new TypedReducer<List<Task>, OnEditTaskAction>(_createNewTasks),
  new TypedReducer<List<Task>, UpdateTaskAction>(_updateTasks),
  new TypedReducer<List<Task>, ClearCompletedTasksAction>(_clearCompletedTasks),
]);

List<Task> _getTasks(List<Task> state, OnGetTaskAction action) {
  return action.tasks;
}

List<Task> _createNewTasks(List<Task> state, OnEditTaskAction action) {
  final createTask = action.editTask;
  if (createTask?.isSuccessful == true) {
    if (createTask.isNew) {
      return new List.of(state)..add(createTask.task);
    } else {
      return _update(state, createTask.task);
    }
  }
  return state;
}

List<Task> _updateTasks(List<Task> state, UpdateTaskAction action) {
  final updatedTask = action.task;
  return _update(state, updatedTask);
}

List<Task> _clearCompletedTasks(
    List<Task> state, ClearCompletedTasksAction action) {
  return state.where((task) => !task.completed).toList(growable: false);
}

List<Task> _update(List<Task> state, Task updatedTask) {
  return state
      .map((task) => task.id == updatedTask.id ? updatedTask : task)
      .toList(growable: false);
}