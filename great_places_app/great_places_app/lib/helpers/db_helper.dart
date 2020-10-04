import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    try {
      await Directory(dbPath).create(recursive: true);
    } catch (err) {
      throw err;
      //debugPrint(err);
    }
    debugPrint(dbPath);

    return sql.openDatabase(
      path.join(
        dbPath,
        'places.db',
      ),
      onCreate: (
        db,
        version,
      ) {
        return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, name TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> create(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    debugPrint(db.toString());
  }

  static Future<List<Map<String, dynamic>>> read(String table) async {
    final db = await DBHelper.database();
    List<Map<String, Object>> list =
        await db.rawQuery('SELECT * FROM user_places');
    debugPrint(list.toString());
    await db.delete('user_places', where: 'name = ?', whereArgs: ['testing']);

    debugPrint(list.toString());
    return db.query(table);
  }
}
