import 'package:flutter/material.dart';

import '../data/Customer.dart';
import '../data/Category.dart';
import '../data/Product.dart';

class DebugPage extends StatefulWidget {
  @override
  _DebugPageState createState() {
    return _DebugPageState();
  }
}

class _DebugPageState extends State<DebugPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _appBar() {
    return AppBar(
      title: Text("DEBUG"),
    );
  }

  Widget _body() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
              child: Text("Generate category"),
              onPressed: () {
                Category.justRandom().save();
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text("Generate category"),
                      content: Text("Category added!!!"),
                    );
                  },
                );
              }),
          RaisedButton(
              child: Text("Generate product"),
              onPressed: () {
                Product.justRandom().save();
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text("Generate product"),
                      content: Text("Product added!!!"),
                    );
                  },
                );
              }),
          RaisedButton(
              child: Text("Generate customer"),
              onPressed: () {
                Customer.justRandom().save();
              })
        ],
      ),
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
