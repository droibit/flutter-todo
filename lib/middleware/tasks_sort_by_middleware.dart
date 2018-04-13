import 'package:redux/redux.dart';

import '../action/tasks_sort_by_action.dart';
import '../model/model.dart';
import 'data/repository/user_settings_repository.dart';

List<Middleware<AppState>> createTasksSortByMiddlewares(
    UserSettingsRepository userSettingsRepository) {
  return <Middleware<AppState>>[
    new TypedMiddleware<AppState, ChangeTasksSortByAction>(
        _tasksSortByMiddleware(userSettingsRepository)),
  ];
}

Middleware<AppState> _tasksSortByMiddleware(UserSettingsRepository repository) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    final sortBy = (action as ChangeTasksSortByAction).tasksSortBy;
    await repository.storeTasksSortBy(sortBy);
    next(action);
  };
}
