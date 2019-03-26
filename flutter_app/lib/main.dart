import 'package:flutter/material.dart';

import 'pages/HomePage.dart';
import 'pages/LoginPage.dart';

const String HOME = "/";
const String LOGIN = "/login";

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo App",
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: HOME,
      routes: {
        HOME: (context) => HomePage(),
        LOGIN: (context) => LoginPage()
      },
    );
  }
}
