import 'package:redux/redux.dart';

import '../model/model.dart';
import 'data/provider/provider.dart';
import 'data/repository/repository.dart';
import 'package_info_middleware.dart';
import 'task_middleware.dart';

final _packageProvider = new PackageProviderImpl();

final _taskRepository = new TaskRepositoryImpl(
  new LocalTaskDataSource(
    new TodoDatabaseImpl()
  ),
);

final appMiddlewares = <Middleware<AppState>>[]
  ..addAll(createTaskMiddlewares(_taskRepository))
  ..addAll(createPackageInfoMiddlewares(_packageProvider));
