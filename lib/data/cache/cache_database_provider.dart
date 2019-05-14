import 'dart:convert';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CacheDatabaseProvider {
  static const databaseFilename = 'cache_data.db';
  static const tableName = 'application_cache';
  static const cacheObjectKey = 'key';
  static const cacheObject = 'object';

  CacheDatabaseProvider._();
  static final CacheDatabaseProvider instance = CacheDatabaseProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
      return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseFilename);
    return await openDatabase(path, version: 1,
        onOpen: (db) { },
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $tableName ("
          "$cacheObjectKey TEXT PRIMARY KEY,"
          "$cacheObject TEXT"
          ")");
    });
  }

  Future<int> insert(String key, dynamic object) async {
    final db = await database;
    if (!(await exists(key)))
      return await db.insert(tableName, objectToMap(key, object));
    return db.update(tableName, objectToMap(key, object),
        where: "$cacheObjectKey = ?",
        whereArgs: [key]);
  }

  Future<dynamic> get(String key) async {
    var result = await _queryByKey(key);
    return result.isNotEmpty ? jsonDecode(result.first[cacheObject]) : null;
  }
  
  Future<bool> exists(String key) async {
    var result = await _queryByKey(key);
    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> _queryByKey(String key) async {
    final db = await database;
    return await db.query(
        tableName,
        where: "$cacheObjectKey = ?",
        whereArgs: [key]);
  }
  
  Map<String, dynamic> objectToMap(String key, dynamic object) => {
    cacheObjectKey: key,
    cacheObject: jsonEncode(object),
  };
}
