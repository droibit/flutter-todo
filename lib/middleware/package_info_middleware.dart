import 'package:redux/redux.dart';

import '../action/package_info_action.dart';
import '../data/provider/package_provider.dart';
import '../model/model.dart';

List<Middleware<AppState>> createPackageInfoMiddleware(PackageProvider packageProvider) {
  return <Middleware<AppState>>[
    _getPackageInfoMiddleware(packageProvider),
  ];
}

Middleware<AppState> _getPackageInfoMiddleware(PackageProvider packageProvider) {
  return (Store<AppState> store, dynamic action, NextDispatcher next) async {
    final packageInfo = await packageProvider.get();
    next(new OnGetPackageInfoAction(packageInfo));
  };
}