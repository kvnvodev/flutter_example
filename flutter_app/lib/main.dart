import 'package:flutter/material.dart';

import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';
import 'pages/DebugPage.dart';

import 'common/DatabaseHandler.dart';

const String HOME = "/";
const String LOGIN = "/login";
const String DEBUG = "/debug";

void main() {
  DatabaseHandler.asyncOpenDatabase();

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
        DEBUG: (context) => DebugPage()
      },
    );
  }
}
