import 'dart:async';
import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter_app/common/DatabaseHandler.dart';

class Product {
  static const String _TABLE_NAME = "products";

  int id;
  String name;
  double price;
  int categoryId;

  Product({this.id: 0, this.name, this.price});

  Product.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.name = json["name"],
        this.price = json["price"],
        this.categoryId = json["category_id"];

  Product.justRandom() {
    final nameWordPair = WordPair.random();

    this.id = 0;
    this.name = nameWordPair.first + " " + nameWordPair.second;
    this.price = Random().nextInt(100000000).toDouble();
    this.categoryId = 1;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "category_id": this.categoryId
    };
  }

  static Future<List<Product>> getListProducts() async {
    final sql = "SELECT * FROM $_TABLE_NAME";
    final results = await DatabaseHandler.query(sql: sql);
    if (results == null) {
      return null;
    }

    return results.map((json) {
      return Product.fromJson(json);
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
        "INSERT INTO $_TABLE_NAME (name, price, category_id) VALUES ('${this.name}', ${this.price}, ${this.categoryId})";
    DatabaseHandler.insert(
        sql: sql,
        callback: (rowid) {
          this.id = rowid;
        });
  }

  void _update() {
    final sql =
        "UPDATE $_TABLE_NAME SET name = '${this.name}', price = ${this.price}, category_id = ${this.categoryId} WHERE id = ${this.id}";
    DatabaseHandler.insert(
        sql: sql,
        callback: (rowid) {
          this.id = rowid;
        });
  }
}
