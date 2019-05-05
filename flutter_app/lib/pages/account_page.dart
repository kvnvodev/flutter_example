import 'package:flutter/material.dart';

class SPAccountPage extends StatefulWidget {
  @override
  _SPAccountPageState createState() => _SPAccountPageState();
}

class _SPAccountPageState extends State<SPAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: RaisedButton(
        child: Text("Login"),
        onPressed: () {
Navigator.of(context).pushNamed("/login");
        },
      ),
    );
  }
}