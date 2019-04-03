import 'package:flutter/material.dart';

import 'package:flutter_app/data/order.dart';
import 'package:flutter_app/data/product.dart';

class OrdersManagementPage extends StatefulWidget {
  @override
  _OrdersManagementPageState createState() => _OrdersManagementPageState();
}

class _OrdersManagementPageState extends State<OrdersManagementPage>
    with TickerProviderStateMixin {
  List<Order> _allOrders;

  @override
  void initState() {
    super.initState();
    fetchListOrders();
  }

  void fetchListOrders() async {
    _allOrders = await Order.fetchListOrders();
    setState(() {});
    print(_allOrders);
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
      child: _allOrders != null
          ? ListView.builder(
              itemCount: _allOrders.length,
              itemBuilder: (context, i) {
                final order = _allOrders[i];
                return OrderItem(
                    key: ObjectKey(order),
                    order: order,
                    animationController: _animationController());
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  AnimationController _animationController() {
    return AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
  }

  void _addOrder() {}
}

class OrderItem extends StatefulWidget {
  final Order order;
  final AnimationController animationController;
  bool toggle;

  OrderItem({Key key, this.order, this.animationController, this.toggle: false})
      : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("#${widget.order.id}", style: TextStyle()),
            Text("Total: ${widget.order.total}", style: TextStyle()),
            Text("#${widget.order.statusName}", style: TextStyle())
          ],
        ),
        SizeTransition(
            axis: Axis.vertical,
            sizeFactor: CurvedAnimation(
                parent: widget.animationController, curve: Curves.easeOut),
            child: ProductList(products: widget.order.products)),
        RaisedButton(
          onPressed: () {
            widget.toggle = !widget.toggle;

            if (widget.toggle) {
              widget.animationController.forward();
            } else {
              widget.animationController.reverse();
            }
          },
          child: Text("View products"),
        )
      ],
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.lightGreen[50])),
        // padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List<Widget>.generate(products.length, (index) {
              return ProductItem(product: products[index]);
            })));
    // return Material(
    //     shape: BeveledRectangleBorder(
    //         borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0))),
    //     child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.stretch,
    //         children: List<Widget>.generate(products.length, (index) {
    //           return ProductItem(product: products[index]);
    //         })));
  }
}

class ProductItem extends StatefulWidget {
  final Product product;

  ProductItem({this.product});

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(10.0),
        child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
          Image.asset("assets/images/icon-placeholder.png",
              width: 60.0, height: 60.0),
          SizedBox(width: 10.0),
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${widget.product.name}", style: Theme.of(context).textTheme.subhead),
                  Text("${widget.product.price}", style: Theme.of(context).textTheme.subtitle),
                  Text("${widget.product.quantity}")
                ],
              ))
        ]));
  }
}
