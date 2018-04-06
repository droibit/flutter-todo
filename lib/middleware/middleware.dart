import 'package:redux/redux.dart';

import '../data/provider/provider.dart';
import '../model/model.dart';
import 'package_info_middleware.dart';

final _packageProvider = new PackageProviderImpl();

final middlewares = <Middleware<AppState>>[]
    ..addAll(createPackageInfoMiddleware(_packageProvider));