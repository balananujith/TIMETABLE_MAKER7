import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBhelper {
  static Database? _db;
  static final int _version = 1;
  static final String tableName = 'tasks';
  // Add a static getter for _db
  static Database? get db => _db;
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + '/tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print('creating a new one');
          return db.execute(
            "CREATE TABLE $tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT,"
                "title STRING,"
                "note TEXT,"
                "date STRING,"
                "startTime STRING,"
                "endTime STRING,"
                "remind INTEGER,"
                "repeat STRING,"
                "color INTEGER,"
                "isCompleted INTEGER,"
                "data TEXT"
                ")",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }
  static Future<void> resetDatabase() async {
    if (_db == null) {
      return;
    }
    try {
      await _db!.transaction((txn) async {
        await txn.delete(tableName);
      });
    } catch (e) {
      print(e);
    }
  }
  static Future<int> delete(int? taskId) async {
    if (_db == null) {
      return -1;
    }
    try {
      return await _db!.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [taskId],
      );
    } catch (e) {
      print(e);
      return -1;
    }
  }

  static Future<int> insert(Task? task) async {
    print('insert function called');
    return await _db?.insert(tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('query function called');
    return await _db!.query(tableName);
  }
}