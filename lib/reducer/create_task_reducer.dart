import 'package:redux/redux.dart';

import '../action/task_action.dart';
import '../model/task.dart';
import '../uitls/optional.dart';

final createTaskReducer = combineReducers<Optional<CreateTask>>([
  new TypedReducer<Optional<CreateTask>, OnCreateTaskAction>(_createTask),
  new TypedReducer<Optional<CreateTask>, CreateTaskResetAction>(
      _resetCreateTask)
]);

Optional<CreateTask> _createTask(
    Optional<CreateTask> state, OnCreateTaskAction action) {
  return new Optional.of(action.createTask);
}

Optional<CreateTask> _resetCreateTask(
    Optional<CreateTask> state, CreateTaskResetAction action) {
  return const Optional.absent();
}
