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
    new TypedMiddleware<AppState, ActivateTaskAction>(
      _activateTaskMiddleware(taskRepository),
    ),
    new TypedMiddleware<AppState, CompleteTaskAction>(
      _completeTaskMiddleware(taskRepository),
    ),
    new TypedMiddleware<AppState, DeleteTaskAction>(
      _completeTaskMiddleware(taskRepository),
    ),
  ];
}

Middleware<AppState> _getTasksMiddleware(TaskRepository taskRepository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    _dispatchGetTasksAction(next, taskRepository);
  };
}

Middleware<AppState> _createTaskMiddleware(TaskRepository taskRepository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    try {
      final a = action as CreateTaskAction;
      final task = await taskRepository.createTask(a.title, a.description);
      debugPrint("Created task: $task");
      next(new OnCreateTaskAction(new CreateTask.success(task)));
    } on Exception catch (e) {
      debugPrint("$e");
      next(new OnCreateTaskAction(new CreateTask.error()));
    }
  };
}

Middleware<AppState> _activateTaskMiddleware(TaskRepository taskRepository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    final task = (action as HasTask).task;
    await taskRepository.activateTask(task.id);
    next(new UpdateTaskAction(task.copy(completed: false)));
  };
}

Middleware<AppState> _completeTaskMiddleware(TaskRepository taskRepository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    final task = (action as HasTask).task;
    await taskRepository.completeTask(task.id);
    next(new UpdateTaskAction(task.copy(completed: true)));
  };
}

Middleware<AppState> _deleteTaskMiddleware(TaskRepository taskRepository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    final task = (action as HasTask).task;
    await taskRepository.deleteTask(task.id);
    next(action);
  };
}

void _dispatchGetTasksAction(
    NextDispatcher next, TaskRepository taskRepository) async {
  final tasks = await taskRepository.getTasks();
  next(new OnGetTaskAction(tasks));
}
