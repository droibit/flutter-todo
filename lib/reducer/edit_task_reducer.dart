import 'package:redux/redux.dart';

import '../action/task_action.dart';
import '../model/task.dart';
import '../uitls/optional.dart';

final editTaskReducer = combineReducers<Optional<EditTask>>([
  new TypedReducer<Optional<EditTask>, OnEditTaskAction>(_onEditTask),
  new TypedReducer<Optional<EditTask>, EditTaskResetAction>(
      _resetEditTask)
]);

Optional<EditTask> _onEditTask(
    Optional<EditTask> state, OnEditTaskAction action) {
  return new Optional.of(action.editTask);
}

Optional<EditTask> _resetEditTask(
    Optional<EditTask> state, EditTaskResetAction action) {
  return const Optional.absent();
}
