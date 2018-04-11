import '../model/model.dart';
import 'package_info_reducer.dart';
import 'task_reducer.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return new AppState(
    tasks: tasksReducer(state.tasks, action),
    tasksFilter: tasksFilterReducer(state.tasksFilter, action),
    createTask: createTaskReducer(state.createTask, action),
    packageInfo: packageInfoReducer(state.packageInfo, action),
  );
}
