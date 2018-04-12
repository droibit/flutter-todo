import 'package:redux/redux.dart';

import '../action/task_action.dart';
import '../model/tasks_sort_by.dart';
import '../uitls/optional.dart';

final tasksSortByReducer = combineReducers<Optional<TasksSortBy>>([]);

