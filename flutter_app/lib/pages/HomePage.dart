import 'package:flutter/material.dart';

import '../data/Customer.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() {
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
    return Center(
      child: RaisedButton(
          child: Text("content"),
          onPressed: () {
            Customer.justRandom().save();
          }),
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
