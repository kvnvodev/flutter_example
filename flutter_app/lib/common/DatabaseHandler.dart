import 'dart:async';
// import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  static final Future<Database> _database = asyncOpenDatabase();

  static Future<Database> asyncOpenDatabase() async {
    return openDatabase(join(await getDatabasesPath(), "demo.db"), version: 1,
        onCreate: (db, version) {
//      final Batch batch = db.batch();
//      batch.execute(sql)
      print("db path: ${db.path}");
      _readFileAssets(path: "assets/sql/create_table_customers.sql").then((sql) {
        return db.execute(sql).whenComplete(() {
          print("open database");
        });
      });
    });
  }

  static void doSomething() async {
    print(await _database);
  }

  static void insert({String sql, OnInsertCallback callback}) async {
    Database db = await _database;
    db.rawInsert(sql).then((rowid) {
      if (callback != null) {
        callback(rowid);
      }
    }).whenComplete(() {
      print("insert completed");
    });
  }

  static Future<String> _readFileAssets({String path}) async {
    final String sql = await rootBundle.loadString(path);
    print("sql content: $sql");
    return sql;
  }
}

typedef void OnInsertCallback(int);
typedef void OnUpdateCallback(int);