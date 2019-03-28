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

  Future<List<Order>> get _listOrders async {
    return await Order.getListOrders();
  }

  // actions
  void _createNewOrder() {
    setState(() {
      Order.justRandom().save();
    });
  }
}

class OrderWidget extends StatefulWidget {
  final int orderId;
  final String statusName;

  OrderWidget({this.orderId, this.statusName});

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool isExanded;

  @override
  void initState() {
    super.initState();
    isExanded = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            isExanded = !isExanded;
          });
        },
        child: Container(
            height: 50,
            // constraints: BoxConstraints.expand(height: isExanded ? 100 : 50),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.yellow))),
            child: _col()));
  }

  Column _col() {
    final children = List<Widget>();
    children.add(Row(children: [
      Text("Order #${widget.orderId}: "),
      Text("2 products"),
      Expanded(flex: 2, child: Text("${widget.statusName}"))
    ]));

    if (isExanded) {
      children.add(Text("expanded"));
    }

    return Column(children: children);
  }
}
