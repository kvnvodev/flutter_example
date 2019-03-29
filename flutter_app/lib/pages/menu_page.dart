import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body()
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Menu"),
    );
  }

  Widget _body() {
    return Container(
      color: Colors.lightBlue[50],
    );
  }
}