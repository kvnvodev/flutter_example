import 'dart:math';

import 'package:english_words/english_words.dart';

import '../common/DatabaseHandler.dart';

class Category {
  static const String _TABLE_NAME = "categories";

  int id;
  String name;
//  bool active;
//  int parent_category_id;

  Category({this.id: 0, this.name});

  Category.fromJson(Map<String, dynamic> json) : this.id = json["id"], this.name = json["name"];

  Category.justRandom() {
    final nameWordPair = WordPair.random();

    this.id = 0;
    this.name = nameWordPair.first + " " + nameWordPair.second;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name
    };
  }

  void save() async {
    final sql = "INSERT INTO $_TABLE_NAME (name) VALUES ('${this.name}')";
    DatabaseHandler.insert(sql: sql, callback: (rowid) {
      this.id = rowid;
    });
  }
}