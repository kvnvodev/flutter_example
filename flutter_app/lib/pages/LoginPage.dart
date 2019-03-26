import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _textfieldController = TextEditingController();

  void _login() {
    print("login with name: ${_textfieldController.value}");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(hintText: "Enter your name"),
            controller: _textfieldController,
          ),
          SizedBox(height: 10.0),
          RaisedButton(
            onPressed: _login,
            child: Text("Login"),
          )
        ],
      ),
    );
  }
}