import 'package:redux/redux.dart';

import '../action/package_info_action.dart';
import '../model/model.dart';
import 'data/provider/package_provider.dart';

List<Middleware<AppState>> createPackageInfoMiddlewares(
    PackageProvider packageProvider) {
  return <Middleware<AppState>>[
    new TypedMiddleware<AppState, GetPackageInfoAction>(
      _getPackageInfoMiddleware(packageProvider),
    ),
  ];
}

Middleware<AppState> _getPackageInfoMiddleware(
    PackageProvider packageProvider) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    final src = await packageProvider.get();
    next(new OnGetPackageInfoAction(
      new PackageInfo(version: src.version),
    ));
  };
}
