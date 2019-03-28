import 'package:flutter/material.dart';

import 'package:flutter_app/pages/HomePage.dart';
import 'package:flutter_app/pages/LoginPage.dart';
import 'package:flutter_app/pages/DebugPage.dart';
import 'package:flutter_app/pages/OrderPage.dart';

import 'package:flutter_app/common/DatabaseHandler.dart';

const String HOME = "/home";
const String LOGIN = "/login";
const String ORDER = "/";
const String DEBUG = "/debug";

void main() async {
  await DatabaseHandler.asyncOpenDatabase();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo App",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: DEBUG,
      routes: {
        HOME: (context) => HomePage(),
        LOGIN: (context) => LoginPage(),
        DEBUG: (context) => DebugPage(),
        ORDER: (context) => OrderPage()
      },
    );
  }
}
