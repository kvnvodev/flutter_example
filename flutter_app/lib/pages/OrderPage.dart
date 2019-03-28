import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/data/Order.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  Widget _appBar() {
    return AppBar(
      title: Text("Order Management"),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
            onTap: _createNewOrder,
            child: Container(
                constraints: BoxConstraints.expand(height: 50),
                margin: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.deepOrange.withAlpha(10),
                    border: Border.all(color: Colors.deepOrange, width: 1.0)),
                child: Center(child: Text("Create New Order")))),
        Text("ORDERS"),
        Expanded(
            flex: 2,
            child: FutureBuilder(
                future: _listOrders,
                builder: (context, asyncSnapshot) {
                  if (!asyncSnapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final List<Order> order = asyncSnapshot.data;
                  return ListView.builder(
                      itemCount: order.length,
                      itemBuilder: (ctx, i) {
                        return OrderWidget(
                            orderId: order[i].id,
                            statusName: order[i].statusName);
                      });
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

  Future<List<Order>> get _listOrders {
    return Order.getListOrders();
  }

  // actions
  void _createNewOrder() {
    Order.justRandom().save();
    setState(() {});
  }
}

class OrderWidget extends StatefulWidget {
  final int orderId;
  final String statusName;
  int val = 0;

  OrderWidget({this.orderId, this.statusName});

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.yellow))),
            child: _col()));
  }

  Column _col() {
    final children = List<Widget>();
    children.add(Row(children: [
      Text("Order #${widget.orderId}: "),
      Text("${widget.val} product(s)"),
      Expanded(flex: 2, child: Text("${widget.statusName}")),
      IconButton(
          icon: Icon(Icons.add, color: Colors.black),
          onPressed: () {
            setState(() {
              widget.val++;
            });
          })
    ]));

    for (int i = 0; i < widget.val; ++i) {
      children.add(Text("product $i"));
    }

    return Column(children: children);
  }
}
