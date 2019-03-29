import 'package:flutter/material.dart';

class OrdersManagementPage extends StatefulWidget {
  @override
  _OrdersManagementPageState createState() => _OrdersManagementPageState();
}

class _OrdersManagementPageState extends State<OrdersManagementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body()
    );
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Orders Management"),
    );
  }

  Widget _body() {
    return Container(
      color: Colors.lightBlue[50],
    );
  }
}