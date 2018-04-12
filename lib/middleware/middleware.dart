import 'package:redux/redux.dart';

import '../model/model.dart';
import 'data/provider/provider.dart';
import 'data/repository/repository.dart';
import 'package_info_middleware.dart';
import 'task_middleware.dart';
import 'tasks_sort_by_middleware.dart';

final _packageProvider = new PackageProviderImpl();

final _taskRepository = new TaskRepositoryImpl(
  new LocalTaskDataSource(new TodoDatabaseImpl()),
);

final _userSettingsRepository = new UserSettingsRepositoryImpl(
  new LocalUserSettingsDataSource(),
);

final appMiddlewares = <Middleware<AppState>>[]
  ..addAll(createTaskMiddlewares(_taskRepository, _userSettingsRepository))
  ..addAll(createTasksSortByMiddlewares(_userSettingsRepository))
  ..addAll(createPackageInfoMiddlewares(_packageProvider));
