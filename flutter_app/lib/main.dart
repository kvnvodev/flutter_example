import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home_page.dart';

void main() {
  // Do something before run app

  // start main
  runApp(SPSpaApp());
}

class SPSpaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SPHomePage(),
    );
  }
}
