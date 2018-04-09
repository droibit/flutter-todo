import 'package:flutter/foundation.dart';

import '../model/task.dart';

class GetTasksAction {}

class OnGetTaskAction {
  final List<Task> tasks;

  OnGetTaskAction(this.tasks) : assert(tasks != null);
}

class ChangeTasksFilterAction {

  final TasksFilter filter;

  ChangeTasksFilterAction(this.filter);
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

class CreateTaskResetAction {
}

