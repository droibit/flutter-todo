import 'package:redux/redux.dart';

import '../action/package_info_action.dart';
import '../model/package_info.dart';
import '../uitls/optional.dart';

final packageInfoReducer = combineReducers<Optional<PackageInfo>>([
  new TypedReducer<Optional<PackageInfo>, OnGetPackageInfoAction>(_getPackageInfo),
]);

Optional<PackageInfo> _getPackageInfo(Optional<PackageInfo> state, OnGetPackageInfoAction action) {
  return new Optional.of(action.packageInfo);
}
