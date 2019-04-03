import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/utils/database_manager.dart';

class OrdersManagementPage extends StatefulWidget {
  @override
  _OrdersManagementPageState createState() => _OrdersManagementPageState();
}

class _OrdersManagementPageState extends State<OrdersManagementPage>
    with TickerProviderStateMixin {
  List<OrderMessage> _orders = [];

  @override
  void initState() {
    super.initState();
    fetchListOrders();
  }

  void fetchListOrders() async {
    final orders = await DatabaseManager.instance.fetchListOrders();
    print(orders);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _appBar(), body: _body());
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Orders Management"),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add, color: Colors.white), onPressed: _addOrder)
      ],
    );
  }

  Widget _body() {
    return Container(
      color: Colors.lightBlue[50],
      child: ListView.builder(
        itemCount: _orders.length,
        itemBuilder: (context, i) {
          return _orders[i];
        },
      ),
    );
  }

  void _addOrder() {
    final AnimationController animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    final OrderMessage message = OrderMessage(
        name: WordPair.random().asPascalCase,
        animationController: animationController);

    _orders.add(message);
    setState(() {});

    message.animationController.forward();
  }
}

class OrderMessage extends StatelessWidget {
  final String name;
  final AnimationController animationController;

  OrderMessage({this.name, this.animationController});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        axis: Axis.vertical,
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 16.0),
              child: new CircleAvatar(child: new Text(name[0])),
            ),
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(name, style: Theme.of(context).textTheme.subhead),
                new Container(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: new Text(name),
                ),
              ],
            ),
          ],
        ));
  }
}
