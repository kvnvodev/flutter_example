import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _appBar() {
    return AppBar(
      title: Text("Demo App"),
    );
  }

  _body() {
    return Column(
      children: <Widget>[
        Container(
          child: Text("Menu"),
        ),
        Container(
          child: Text("Orders Management"),
        )
      ],
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
