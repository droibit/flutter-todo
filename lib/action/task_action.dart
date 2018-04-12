import 'package:flutter/foundation.dart';

import '../model/model.dart';

class GetTasksAction {}

class OnGetTaskAction {
  final List<Task> tasks;

  final TasksSortBy tasksSortBy;

  OnGetTaskAction(this.tasks, this.tasksSortBy)
      : assert(tasks != null),
        assert(tasksSortBy != null);
}

class CreateTaskAction {
  final String title;

  final String description;

  CreateTaskAction({
    @required this.title,
    this.description,
  }) : assert(title != null);
}

class OnCreateTaskAction {
  final CreateTask createTask;

  OnCreateTaskAction(this.createTask) : assert(createTask != null);
}

class CreateTaskResetAction {}

class HasTask {
  Task task;

  HasTask(this.task);
}

class CompleteTaskAction extends HasTask {
  CompleteTaskAction(Task task) : super(task);
}

class ActivateTaskAction extends HasTask {
  ActivateTaskAction(Task task) : super(task);
}

class DeleteTaskAction extends HasTask {
  DeleteTaskAction(Task task) : super(task);
}

class UpdateTaskAction extends HasTask {
  UpdateTaskAction(Task task) : super(task);
}
