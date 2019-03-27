import 'package:flutter/material.dart';
import 'package:flutter_app/data/Product.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget _appBar() {
    return AppBar(
      title: Text("Home"),
    );
  }

  Widget _body() {
    return StreamBuilder(
        initialData: [],
        stream: Stream.fromFuture(Product.getListProducts()),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (ctx, idx) {
                final Product product = snapshot.data[idx];
                return ListTile(title: Text(product.name));
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }
}
