import 'package:english_words/english_words.dart';
import 'package:flutter_app/common/DatabaseHandler.dart';

class Category {
  static const String _TABLE_NAME = "categories";

  int id;
  String name;
  bool active;
  int parentCategoryId;

  Category({this.id: 0, this.name});

  Category.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.name = json["name"],
        this.active = json["active"],
        this.parentCategoryId = json["parent_category_id"];

  Category.justRandom() {
    final nameWordPair = WordPair.random();

    this.id = 0;
    this.name = nameWordPair.first + " " + nameWordPair.second;
    this.active = true;
    this.parentCategoryId = 0;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "active": this.active,
      "parent_category_id": this.parentCategoryId
    };
  }

  void save() {
    if (this.id == 0) {
      _insert();
    } else {
      _update();
    }
  }

  void _insert() {
    final sql = "INSERT INTO $_TABLE_NAME (name) VALUES ('${this.name}')";
    DatabaseHandler.insert(
        sql: sql,
        callback: (rowid) {
          this.id = rowid;
        });
  }

  void _update() {
    final sql =
        "UPDATE $_TABLE_NAME name ='${this.name}' WHERE id = ${this.id}";
    DatabaseHandler.update(
        sql: sql,
        callback: (rowid) {
          this.id = rowid;
        });
  }
}
