import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

//import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class HomePage extends StatefulWidget {
//  Future<Database> database;

  void openDB() async {
//    final Future<Database> database =
//        openDatabase(join(await getDatabasesPath(), "demo.db"), version: 1,
//            onCreate: (db, version) {
//      print("db path: ${db.path}");
      final sql = readFileAssets(path: "assets/sql/create_tables.sql");
      print(sql);
      sql.then((content) {
//        return db.execute(content);
      });
//    });
  }

  Future<String> readFileAssets({String path}) async {
    final String sql = await rootBundle.loadString(path);
    print("sql content: $sql");
    return sql;
  }

  @override
  _HomePageState createState() {
    openDB();

    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Home"),
    );
  }

  Widget _body() {
    return Container(
      child: Text("content"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }
}
