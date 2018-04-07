import 'package:redux/redux.dart';

import '../action/package_info_action.dart';
import '../model/package_info.dart';

final packageInfoReducer = combineReducers<PackageInfo>(
    [new TypedReducer<PackageInfo, OnGetPackageInfoAction>(_getPackageInfo)]);

PackageInfo _getPackageInfo(PackageInfo state, OnGetPackageInfoAction action) {
  return action.packageInfo;
}
