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

Middleware<AppState> _getTasksMiddleware(TaskRepository taskRepository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    final tasks = await taskRepository.getTasks();
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

      final tasks = await taskRepository.getTasks();
      next(new OnGetTaskAction(tasks));
    } on Exception catch (e) {
      debugPrint("$e");
      next(new OnCreateTaskAction(new CreateTask.error()));
    }
  };
}
