import 'package:flutter/material.dart';

import 'package:flutter_app/utils/app_constants.dart' as app;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _appBar() {
    return AppBar(
      title: Text("Demo App"),
    );
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(app.defaultSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _HomeCard(
              onTap: () {
                _navigateTo(routeName: app.routeNameMenu);
              },
              child: Center(child: Text("Menu")),
            ),
          ),
          SizedBox(height: app.defaultSpacing),
          Expanded(
            flex: 1,
            child: _HomeCard(
              onTap: () {
                _navigateTo(routeName: app.routeNameOrdersManagement);
              },
              child: Center(child: Text("Orders Management")),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  void _navigateTo({routeName: String}) {
    Navigator.of(context).pushNamed(routeName);
  }
}

class _HomeCard extends StatelessWidget {
  final Widget child;
  final Function onTap;

  _HomeCard({Key key, this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: app.defaultCardElevation,
        borderOnForeground: false,
        margin: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(app.defaultCardRadius)),
        color: Colors.lightGreen[100],
        child: child,
      ),
    );
  }
}
