import 'package:flutter/material.dart';

class DebugPage extends StatefulWidget {
  @override
  _DebugPageState createState() {
    return _DebugPageState();
  }
}

class _DebugPageState extends State<DebugPage> {
  int val = 0;

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
          Text("val: $val"),
          RaisedButton(
              child: Text("decrement"),
              onPressed: () {
                setState(() {
                  val--;
                });
                // showDialog(
                //   context: context,
                //   builder: (ctx) {
                //     return AlertDialog(
                //       title: Text("Generate category"),
                //       content: Text("Category added!!!"),
                //     );
                //   },
                // );
              }),
          RaisedButton(
              child: Text("increment"),
              onPressed: () {
                setState(() {
                  val++;
                });
                // showDialog(
                //   context: context,
                //   builder: (ctx) {
                //     return AlertDialog(
                //       title: Text("Generate product"),
                //       content: Text("Product added!!!"),
                //     );
                //   },
                // );
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
