import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    try {
      await Directory(dbPath).create(recursive: true);
    } catch (err) {
      throw err;
      // debugPrint(err);
    }

    debugPrint(dbPath);

    return sql.openDatabase(
      path.join(
        dbPath,
        'groceries.db',
      ),
      onCreate: (
        db,
        version,
      ) {
        return db.execute(
          '''CREATE TABLE user_groceries(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            created_on DATETIME NOT NULL DEFAULT (datetime(CURRENT_TIMESTAMP, 'localtime')),
            items TEXT)''',
        );
      },
      version: 1,
    );
  }

  static Future<void> createList(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
    debugPrint(db.toString());
  }

  static Future<List<Map<String, dynamic>>> read(String table) async {
    final db = await DBHelper.database();
    List<Map<String, Object>> list =
        await db.rawQuery('SELECT * FROM user_groceries');

    debugPrint(list.toString());

    return db.query(table);
  }

  static Future<List<Map<String, dynamic>>> update(
      String table, Map<String, Object> data) async {
    final db = await DBHelper.database();

    db.update(table, data, where: "id = $data.id", whereArgs: []);
    return db.query(table);
  }
}
