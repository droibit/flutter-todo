import 'dart:async';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

const _databaseDirName = "database";
const _todoDbName = "todo.db";

class DbConfig {
  static Future<String> getTodoDbPath() async {
    final documentDir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(documentDir.path, _databaseDirName, _todoDbName);
    final dbDir = new Directory(p.dirname(dbPath));
    if (await dbDir.exists()) {
      return dbPath;
    }
    await dbDir.create(recursive: true);
    return dbPath;
  }
}
