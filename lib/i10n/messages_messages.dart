// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

// ignore: unused_element
final _keepAnalysisHappy = Intl.defaultLocale;

// ignore: non_constant_identifier_names
typedef MessageIfAbsent(String message_str, List args);

class MessageLookup extends MessageLookupByLibrary {
  get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "appCategory" : MessageLookupByLibrary.simpleMessage("App"),
    "buildVersionSubtitle" : MessageLookupByLibrary.simpleMessage("Version: "),
    "buildVersionTitle" : MessageLookupByLibrary.simpleMessage("Build version"),
    "newTask" : MessageLookupByLibrary.simpleMessage("New TO-DO"),
    "newTaskDescHint" : MessageLookupByLibrary.simpleMessage("Enter your TO-DO here."),
    "newTaskDescLabel" : MessageLookupByLibrary.simpleMessage("Description"),
    "newTaskFailedToCreate" : MessageLookupByLibrary.simpleMessage("Failed to create new TO-DO."),
    "newTaskSuccessfulToCreate" : MessageLookupByLibrary.simpleMessage("TO-DO created."),
    "newTaskTitleLabel" : MessageLookupByLibrary.simpleMessage("Title"),
    "newTaskTitleValidationError" : MessageLookupByLibrary.simpleMessage("Title is required."),
    "noTasks" : MessageLookupByLibrary.simpleMessage("No TO-DOs."),
    "settings" : MessageLookupByLibrary.simpleMessage("Settings"),
    "sourceCodeTitle" : MessageLookupByLibrary.simpleMessage("Source code"),
    "statistics" : MessageLookupByLibrary.simpleMessage("Statistics"),
    "statisticsActiveTasks" : MessageLookupByLibrary.simpleMessage("Active TO-DOs:"),
    "statisticsCompletedTasks" : MessageLookupByLibrary.simpleMessage("Completed TO-DOs:"),
    "title" : MessageLookupByLibrary.simpleMessage("TO-DO"),
    "todoList" : MessageLookupByLibrary.simpleMessage("TO-DO List"),
    "todoListClearCompleted" : MessageLookupByLibrary.simpleMessage("Clear completed"),
    "todoListFilterActive" : MessageLookupByLibrary.simpleMessage("Active"),
    "todoListFilterAll" : MessageLookupByLibrary.simpleMessage("All"),
    "todoListFilterCompleted" : MessageLookupByLibrary.simpleMessage("Completed"),
    "todoListHeaderActive" : MessageLookupByLibrary.simpleMessage("Active TO-DOs"),
    "todoListHeaderAll" : MessageLookupByLibrary.simpleMessage("All TO-DOs"),
    "todoListHeaderCompleted" : MessageLookupByLibrary.simpleMessage("Completed TO-DOs"),
    "todoListSortBy" : MessageLookupByLibrary.simpleMessage("Sort by"),
    "todoListSortByCreatedDate" : MessageLookupByLibrary.simpleMessage("Created Date"),
    "todoListSortByTitle" : MessageLookupByLibrary.simpleMessage("Title")
  };
}
