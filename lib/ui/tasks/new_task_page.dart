import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../action/task_action.dart';
import '../../i10n/app_localizations.dart';
import '../../model/model.dart';
import '../../uitls/optional.dart';

typedef void _OnSubmitCallback(String title, String description);

class NewTaskPage extends StatelessWidget {
  final _titleController = new TextEditingController();

  final _descriptionController = new TextEditingController();

  NewTaskPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _OnSubmitCallback>(
      converter: (store) {
        return (title, description) {
          store.dispatch(new CreateTaskAction(
            title: title,
            description: description,
          ));
        };
      },
      builder: (context, submitCallback) => _build(context, submitCallback),
    );
  }

  Widget _build(BuildContext context, _OnSubmitCallback submitCallback) {
    final localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return new Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: new Text(localizations.newTask),
        actions: <Widget>[
          new _CreateTaskActionButton(
            _titleController,
            _descriptionController,
            submitCallback,
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
                labelText: localizations.newTaskTitleLabel,
              ),
              maxLines: 1,
              maxLength: 60,
            ),
            const SizedBox(height: 24.0),
            new Text(
              localizations.newTaskDescLabel,
              textAlign: TextAlign.start,
              style:
                  theme.textTheme.caption.copyWith(color: theme.primaryColor),
            ),
            new TextField(
              controller: _descriptionController,
              decoration: new InputDecoration(
                hintText: localizations.newTaskDescHint,
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
          context, AppLocalizations.of(context).newTaskTitleValidationError);
      return;
    }
    debugPrint("newTask.title:$title, description: $description");
    _submitCallback(title, description);

    // TODO: dismiss keyboard.
  }
}

void _showSnackbar(BuildContext context, String message) {
  Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text(message),
      ));
}
