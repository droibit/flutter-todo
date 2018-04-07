import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';

import '../action/task_action.dart';
import '../model/model.dart';
import 'data/repository/task_repository.dart';

List<Middleware<AppState>> createTaskMiddlewares(
    TaskRepository taskRepository) {
  return <Middleware<AppState>>[
    new TypedMiddleware<AppState, GetTasksAction>(
      _getTasksMiddleware(taskRepository),
    ),
    new TypedMiddleware<AppState, CreateTaskAction>(
      _createTaskMiddleware(taskRepository),
    ),
  ];
}

Middleware<AppState> _getTasksMiddleware(TaskRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    final tasks = await repository.getTasks();
    next(new OnGetTaskAction(tasks));
  };
}

Middleware<AppState> _createTaskMiddleware(TaskRepository taskRepository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    try {
      final a = action as CreateTaskAction;
      final task = await taskRepository.createTask(a.title, a.description);
      debugPrint("Created task: $task");
      next(new OnCreateTaskAction(new CreateTask.success(task)));
      // TODO: emit OnGetTaskAction or refresh action.
    } catch (e) {
      debugPrint(e);
      next(new OnCreateTaskAction(new CreateTask.error()));
    }
  };
}
