import 'package:flutter/material.dart';
import 'package:flutter_app/data/Product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController animController;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  GlobalKey<_HomePageListBuilderState> _builderKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    this.animController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Home"),
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        },
      ),
      actions: [
        GestureDetector(
            child: AnimatedIcon(
                icon: AnimatedIcons.view_list, progress: this.animController),
            onTap: () {
              _builderKey.currentState.setState(() {
                _builderKey.currentState.widget.showAsGrid =
                    !_builderKey.currentState.widget.showAsGrid;
              });

              if (this.animController.status != AnimationStatus.forward &&
                  this.animController.status != AnimationStatus.completed) {
                this.animController.forward();
              } else {
                this.animController.reverse();
              }
            })
      ],
    );
  }

  Widget _body() {
    return Container();
    // return StreamBuilder(
    //     initialData: [],
    //     stream: Stream.fromFuture(Product.getListProducts()),
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return Container();
    //       }

    //       return HomePageListBuilder(key: _builderKey, products: snapshot.data);
    //     });
  }

  Widget _drawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("menu item 1"),
          Text("menu item 1"),
          Text("menu item 1")
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      drawer: _drawer(),
    );
  }
}

class HomePageListBuilder extends StatefulWidget {
  final List<Product> products;

  bool showAsGrid = false;

  HomePageListBuilder({Key key, this.products, this.showAsGrid: false})
      : super(key: key);

  @override
  _HomePageListBuilderState createState() => _HomePageListBuilderState();
}

class _HomePageListBuilderState extends State<HomePageListBuilder> {
  Widget _listView() {
    return ListView.builder(
        itemCount: widget.products.length,
        itemBuilder: (ctx, idx) {
          final Product product = widget.products[idx];
          return Container(
              color: Colors.lightGreen,
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: Row(children: [
                Image.network("https://picsum.photos/250?image=9",
                    width: 60.0, height: 60.0),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name),
                    Text(product.price.toString())
                  ],
                )
              ]));
        });
  }

  Widget _gridView() {
    final delegate = SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2);
    return GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: delegate,
        itemCount: widget.products.length,
        itemBuilder: (ctx, idx) {
          final Product product = widget.products[idx];
          return Container(
              color: Colors.lightGreen,
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
              child: Column(children: [
                Image.network("https://picsum.photos/250?image=9",
                    width: 60.0, height: 60.0),
                SizedBox(height: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name),
                    Text(product.price.toString())
                  ],
                )
              ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    final widget = !this.widget.showAsGrid ? _gridView() : _listView();
    return widget;
  }
}
