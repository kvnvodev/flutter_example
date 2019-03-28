import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Widget _appBar() {
    return AppBar(
      title: Text("Order food"),
    );
  }

  Widget _body() {
    return Column(
      children: [
        GestureDetector(
            onTap: _addProducts,
            child: Container(
                constraints: BoxConstraints.expand(height: 50),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.deepOrange.withAlpha(10),
                    border: Border.all(color: Colors.deepOrange, width: 1.0)),
                child: Center(child: Text("Add products")))),
        Expanded(
            flex: 2,
            child: ListView.builder(
                itemCount: 20,
                itemBuilder: (ctx, i) {
                  return Container(
                      constraints: BoxConstraints.expand(height: 50),
                      child: Center(child: Text("Product $i")));
                }))
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

  // actions
  void _addProducts() {}
}
