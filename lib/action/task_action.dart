import 'package:flutter/foundation.dart';

class GetTasksAction {}

class CreateTaskAction {
  final String title;

  final String description;

  CreateTaskAction({
    @required this.title,
    this.description,
  }) : assert(title?.isNotEmpty);
}
