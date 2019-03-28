import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  static Future<Database> _database;

  static Future<void> asyncOpenDatabase() async {
    final Database db = await _database;
    if (db != null && db.isOpen) {
      return;
    }

    _database = openDatabase(join(await getDatabasesPath(), "demo.db"),
        version: 1, onCreate: (db, version) {
      final Batch batch = db.batch();

//      final stream = Stream.fromFutures([
//        _readFileAssets(path: "assets/sql/create_table_categories.sql"),
//        _readFileAssets(path: "assets/sql/create_table_products.sql"),
//        _readFileAssets(path: "assets/sql/create_table_customers.sql"),
//        _readFileAssets(path: "assets/sql/create_table_orders.sql"),
//        _readFileAssets(path: "assets/sql/create_table_order_details.sql")
//      ]);
//
//      stream.forEach((sql) {
//        batch.execute(sql);
//      }).whenComplete(() {
//        batch.commit();
//      });

    //   final _paths = [
    //     "assets/sql/create_table_categories.sql",
    //     "assets/sql/create_table_products.sql",
    //     "assets/sql/create_table_customers.sql",
    //     "assets/sql/create_table_orders.sql",
    //     "assets/sql/create_table_order_details.sql"
    //   ];

    //   Future.wait(_paths.map((path) => _readFileAssets(path: path)))
    //       .then((list) {
    //     list.forEach((sql) {
    //       batch.execute(sql);
    //     });
    //   }).whenComplete(() {
    //     batch.commit();
    //   });

    //   print("db path: ${db.path}");

      _readFileAssets(path: "assets/sql/demo.sql").then((sql) {
        sql.split(";").forEach((statement) {
          if (statement.length != 0) { 
            batch.execute(statement);
          }
        });

        batch.commit();
      });
    });
  }

  static void closeDatabase() async {
    Database db = await _database;
    db.close();
  }

  static Future<List<Map<String, dynamic>>> query({String sql}) async {
    final Database db = await _database;
    if (db == null || !db.isOpen) {
      return null;
    }
    return db.rawQuery(sql);
  }

  static Future<void> insert({String sql, OnInsertCallback callback}) async {
    final Database db = await _database;
    if (db == null || !db.isOpen) {
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

  static void update({String sql, OnUpdateCallback callback}) async {
    final Database db = await _database;
    db.rawUpdate(sql).then((rowid) {
      if (callback != null) {
        callback(rowid);
      }
    }).whenComplete(() {
      print("update completed");
    });
  }

  static Future<String> _readFileAssets({String path}) async {
    final String sql = await rootBundle.loadString(path);
    print("sql content: $sql");
    return sql;
  }

  static Future<List<Map<String, dynamic>>> queryOrder({String sql: "SELECT o.id, o.status_id, s.name, o.total FROM orders o LEFT JOIN order_status s ON o.status_id = s.id"}) async {
    final Database db = await _database;
    if (db == null || !db.isOpen) {
      return null;
    }
    return db.rawQuery(sql);
  }
}

typedef void OnInsertCallback(int);
typedef OnUpdateCallback = void Function(int);
