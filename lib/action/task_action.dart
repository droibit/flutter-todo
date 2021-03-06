import 'package:flutter/foundation.dart';

import '../model/model.dart';

class HasTask {
  Task task;

  HasTask(this.task);
}

class GetTasksAction {}

class OnGetTaskAction {
  final List<Task> tasks;

  final TasksSortBy tasksSortBy;

  OnGetTaskAction(this.tasks, this.tasksSortBy)
      : assert(tasks != null);
}

class CreateTaskAction {
  final String title;

  final String description;

  CreateTaskAction({
    @required this.title,
    this.description,
  }) : assert(title != null);
}

class EditTaskAction extends HasTask {

  EditTaskAction(Task task) : super(task);
}

class OnEditTaskAction {
  final EditTask editTask;

  OnEditTaskAction(this.editTask) : assert(editTask != null);
}

class EditTaskResetAction {}

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

class ClearCompletedTasksAction {
}