import 'dart:async';
import 'dart:math';

import 'package:flutter_app/common/DatabaseHandler.dart';

class Order {
  static const String TABLE_ORDERS = "orders";

  int id;
  double total;
  int statusId;
  String statusName;

  Order({this.id: 0, this.total, this.statusId});

  Order.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.total = json["total"],
        this.statusId = json["status_id"],
        this.statusName = json["status_name"];

  Order.justRandom() {
    this.id = 0;
    this.total = Random().nextInt(100000000).toDouble();
    this.statusId = 1;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "total": this.total,
      "status_id": this.statusId,
      "status_name": this.statusName
    };
  }

  static Future<List<Order>> getListOrders() async {
    final sql = "SELECT o.id, o.status_id, s.name AS status_name, o.total FROM $TABLE_ORDERS o LEFT JOIN order_status s ON o.status_id = s.id";
    final results = await DatabaseHandler.query(sql: sql);
    if (results == null) {
      return null;
    }

    return results.map((json) {
      return Order.fromJson(json);
    }).toList();
  }

  void save() {
    if (this.id == 0) {
      _insert();
    } else {
      _update();
    }
  }

  void _insert() {
    final sql =
        "INSERT INTO $TABLE_ORDERS (total, status_id) VALUES (${this.total}, ${this.statusId})";
    DatabaseHandler.insert(
        sql: sql,
        callback: (rowid) {
          this.id = rowid;
        });
  }

  void _update() {
    final sql =
        "UPDATE $TABLE_ORDERS SET total = ${this.total}, status_id = ${this.statusId} WHERE id = ${this.id}";
    DatabaseHandler.insert(
        sql: sql,
        callback: (rowid) {
          this.id = rowid;
        });
  }
}
