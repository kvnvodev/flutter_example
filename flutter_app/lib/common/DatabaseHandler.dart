import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  static Future<Database> _database;

  static void asyncOpenDatabase() async {
    final Database db = await _database;
    if (db != null && db.isOpen) {
      return;
    }

    _database = openDatabase(join(await getDatabasesPath(), "demo.db"), version: 1,
        onCreate: (db, version) {
      final Batch batch = db.batch();

      final stream = Stream.fromFutures([
        _readFileAssets(path: "assets/sql/create_table_categories.sql"),
        _readFileAssets(path: "assets/sql/create_table_products.sql"),
        _readFileAssets(path: "assets/sql/create_table_customers.sql"),
        _readFileAssets(path: "assets/sql/create_table_orders.sql"),
        _readFileAssets(path: "assets/sql/create_table_order_details.sql")
      ]);

      stream.forEach((sql) {
        batch.execute(sql);
      }).whenComplete(() {
        batch.commit();
      });

      print("db path: ${db.path}");
    });
  }

  static void closeDatabase() async {
    Database db = await _database;
    db.close();
  }

  static void insert({String sql, OnInsertCallback callback, int times: 0}) async {
    if (times == 5) {
      print("RETRY insert times exceed $times");
      return;
    }

    final Database db = await _database;
    if (db == null || !db.isOpen) {
      asyncOpenDatabase();

      print("RETRY insert ${times + 1} times");
      insert(sql: sql, callback: callback, times: times + 1);
      return;
    }

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
