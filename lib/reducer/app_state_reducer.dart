import 'package:redux/redux.dart';

import '../model/model.dart';
import 'package_info_reducer.dart';
import 'task_reducer.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return new AppState(
    tasks: [],  // TODO: replace taskReducer
    packageInfo: packageInfoReducer(state.packageInfo, action),
  );
}