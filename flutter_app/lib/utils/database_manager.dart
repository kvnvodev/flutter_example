import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart' show rootBundle;

/// A class to manage connection with SQLite database
class DatabaseManager {
  static const tableOrders = "orders";

  static final DatabaseManager instance = DatabaseManager();

  Database _database;
  Database get database => _database;

  String get _dbFileName => "demo.app";
  String get _sqlFileName => "assets/sql/demo.sql";
  String get _sqlStatementSeparate => "---";

  FutureOr<void> openDB() async {
    if (_database != null && _database.isOpen) {
      return;
    }

    // determine onCreate, onUpgrade or onDowngrade is specified based on version
    // database is not existed => onCreate
    // oldVersion < newVersion => onUpgrade
    // oldVersion > newVersion => onDowngrade

    _database = await openDatabase(join(await getDatabasesPath(), _dbFileName),
        version: 1,
        onCreate: _onDBCreate,
        onUpgrade: _onDBVersionChange,
        onDowngrade: _onDBVersionChange);
  }

  void closeDB() {
    if (_database != null && _database.isOpen) {
      _database.close();
    }
  }

  /// implement later
  void _upgradeDB() {
    // increase db version
    // cause function onUpgrade invoked while openDatabase call
    closeDB();
    openDB();
  }

  /// implement later
  void _downgradeDB() {
    // decrease db version
    // cause function onDowngrade invoked while openDatabase calling
    closeDB();
    openDB();
  }

  FutureOr<void> _onDBCreate(Database db, int version) async {
    final statements = await rootBundle.loadString(_sqlFileName);

    await db.transaction((txn) {
      final Batch batch = txn.batch();

      statements.split(_sqlStatementSeparate).forEach((sqlStatement) {
        if (sqlStatement.length != 0) {
          batch.execute(sqlStatement);
        }
      });

      batch.commit();
    });
  }

  /// implement later
  void _onDBVersionChange(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      print("UPGRADE Database, old - new: $oldVersion - $newVersion");
    } else {
      print("DOWNGRADE Database, old - new: $oldVersion - $newVersion");
    }
  }
}

class DatabaseConstants {
  static const tableProducts = "products";
  static const tableOrders = "orders";
  static const tableOrderStatus = "order_status";
  static const tableOrderDetails = "order_details";

  static final sqlFetchListOrders = """
  SELECT o.id, o.status_id, s.name AS status_name, o.total, d.product_id AS product_id, p.name AS product_name, d.quantity, d.price, p.category_id
    FROM ${DatabaseConstants.tableOrders} o 
    LEFT JOIN ${DatabaseConstants.tableOrderStatus} s 
    ON o.status_id = s.id
    LEFT JOIN ${DatabaseConstants.tableOrderDetails} d
    ON o.id = d.order_id
    LEFT JOIN ${DatabaseConstants.tableProducts} p
    ON d.product_id = p.id
    ORDER BY o.id
  """;
}


