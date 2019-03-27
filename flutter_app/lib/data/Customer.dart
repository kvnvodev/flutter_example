import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter_app/common/DatabaseHandler.dart';

class Customer {
  static const String _TABLE_NAME = "customers";

  int id;
  String name;
  String address;

  Customer({this.id: 0, this.name, this.address});

  Customer.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.name = json["name"],
        this.address = json["address"];

  Customer.justRandom() {
    final nameWordPair = WordPair.random();
    final addressWordPair = WordPair.random();

    this.id = 0;
    this.name = nameWordPair.first + " " + nameWordPair.second;
    this.address = Random().nextInt(10000).toString() +
        " " +
        addressWordPair.first +
        " " +
        addressWordPair.second;
  }

  Map<String, dynamic> toJson() {
    return {"id": this.id, "name": this.name, "address": this.address};
  }

  static Future<List<Map<String, dynamic>>> getListCustomers() async {
    final sql = "SELECT * FROM $_TABLE_NAME";
    final results = await DatabaseHandler.query(sql: sql);
    return results;
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
        "INSERT INTO $_TABLE_NAME (name, address) VALUES ('${this.name}', '${this.address}')";
    DatabaseHandler.insert(
        sql: sql,
        callback: (rowid) {
          this.id = rowid;
        });
  }

  void _update() {
    final sql =
        "UPDATE $_TABLE_NAME SET name = '${this.name}', address = '${this.address}' WHERE id = ${this.id}";
    DatabaseHandler.insert(
        sql: sql,
        callback: (rowid) {
          this.id = rowid;
        });
  }
}
