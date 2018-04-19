import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../action/task_action.dart';
import '../../i10n/app_localizations.dart';
import '../../model/model.dart';
import '../../uitls/optional.dart';

typedef void _OnSubmitCallback(String title, String description);

class EditTaskPage extends StatefulWidget {
  final Task targetTask;

  EditTaskPage.updateTask(this.targetTask, {Key key})
      : assert(targetTask != null),
        super(key: key);

  EditTaskPage.newTask({Key key})
      : targetTask = null,
        super(key: key);

  @override
  State createState() => new EditTaskPageState(targetTask);
}

class EditTaskPageState extends State<EditTaskPage> {
  final TextEditingController _titleController;

  final TextEditingController _descriptionController;

  final Task targetTask;

  EditTaskPageState(this.targetTask)
      : _titleController = new TextEditingController(text: targetTask?.title),
        _descriptionController =
            new TextEditingController(text: targetTask?.description);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return new StoreConnector<AppState, _EditTaskViewModel>(
      converter: (store) {
        return new _EditTaskViewModel.from(
          store,
          title: targetTask == null
              ? localizations.newTask
              : localizations.editTask,
          targetTask: targetTask,
        );
      },
      builder: (context, viewModel) => _build(context, viewModel),
    );
  }

  Widget _build(BuildContext context, _EditTaskViewModel viewModel) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: new Text(viewModel.title),
        actions: <Widget>[
          new _CreateTaskActionButton(
            _titleController,
            _descriptionController,
            viewModel.onSubmitCallback,
          )
        ],
      ),
      body: new SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new TextField(
              controller: _titleController,
              decoration: new InputDecoration(
                border: const UnderlineInputBorder(),
                labelText: localizations.editTaskTitleLabel,
              ),
              maxLines: 1,
              maxLength: 60,
            ),
            const SizedBox(height: 24.0),
            new Text(
              localizations.editTaskDescLabel,
              textAlign: TextAlign.start,
              style:
                  theme.textTheme.caption.copyWith(color: theme.primaryColor),
            ),
            new TextField(
              controller: _descriptionController,
              decoration: new InputDecoration(
                hintText: localizations.editTaskDescHint,
              ),
              keyboardType: TextInputType.multiline,
              maxLength: 500,
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class _EditTaskViewModel {
  final String title;

  final Task targetTask;

  final Function(String, String) onSubmitCallback;

  bool get isUpdate => targetTask != null;

  _EditTaskViewModel._internal({
    @required this.title,
    @required this.targetTask,
    @required this.onSubmitCallback,
  })  : assert(title?.isNotEmpty == true),
        assert(onSubmitCallback != null);

  factory _EditTaskViewModel.from(Store<AppState> store,
      {String title, Task targetTask}) {
    return new _EditTaskViewModel._internal(
      title: title,
      targetTask: targetTask,
      onSubmitCallback: (title, description) {
        if (targetTask == null) {
          store.dispatch(new CreateTaskAction(
            title: title,
            description: description,
          ));
        } else {
          // TODO:
        }
      },
    );
  }
}

class _CreateTaskActionButton extends StatelessWidget {
  final TextEditingController _titleController;

  final TextEditingController _descriptionController;

  final _OnSubmitCallback _submitCallback;

  _CreateTaskActionButton(
    this._titleController,
    this._descriptionController,
    this._submitCallback,
  );

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, Optional<CreateTask>>(
      distinct: true,
      converter: (store) => store.state.createTask,
      onWillChange: (createTask) => _onCreateTask(context, createTask),
      builder: (context, _) {
        return new IconButton(
          icon: new Icon(
            Icons.done,
            color: Theme.of(context).accentIconTheme.color,
          ),
          onPressed: () {
            final title = _titleController.text;
            final description = _descriptionController.text;
            _onSubmit(context, title, description);
          },
        );
      },
      onDispose: (store) => store.dispatch(new CreateTaskResetAction()),
    );
  }

  void _onCreateTask(BuildContext context, Optional<CreateTask> createTask) {
    // ignore initial state.
    createTask.ifPresent((v) {
      if (v.isSuccessful) {
        Navigator.pop(context, true);
      } else {
        _showSnackbar(
            context, AppLocalizations.of(context).newTaskFailedToCreate);
      }
      debugPrint("_onCreateTask(isSuccessful=${v.isSuccessful})");
    });
  }

  void _onSubmit(BuildContext context, String title, String description) {
    if (title.trim().isEmpty) {
      _showSnackbar(
          context, AppLocalizations.of(context).editTaskTitleValidationError);
      return;
    }
    debugPrint("newTask.title:$title, description: $description");
    _submitCallback(title, description);

    // TODO: dismiss keyboard.
  }
}

void _showSnackbar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(
        new SnackBar(
          content: new Text(message),
        ),
      );
}
