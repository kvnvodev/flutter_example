import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:flutter_app/common/backdrop.dart';

import 'package:flutter_app/pages/home_page.dart';
import 'package:flutter_app/pages/orders_management_page.dart';
import 'package:flutter_app/pages/menu_page.dart';

import 'package:flutter_app/utils/app_constants.dart' as app;
import 'package:flutter_app/utils/database_manager.dart';

void main() async {
  await DatabaseManager.instance.openDB();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo App",
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      // initialRoute: app.routeNameHome,
      // routes: {
      //   app.routeNameHome: (context) => HomePage(),
      //   app.routeNameOrdersManagement: (context) => OrdersManagementPage(),
      //   app.routeNameMenu: (context) => MenuPage()
      // },
      // home: Backdrop(
      //   backLayer: Menu(),
      // ),
      initialRoute: "/",
      onGenerateRoute: (settings) {
        final routes = {
          app.routeNameRoot: (context) => Backdrop(
                backLayer: Menu(),
              ),
          app.routeNameOrdersManagement: (context) => OrdersManagementPage(),
          app.routeNameMenu: (context) => MenuPage()
        };

        if (!routes.containsKey(settings.name)) return null;

        return MaterialPageRoute(
            settings: settings,
            builder: routes[settings.name],
            fullscreenDialog: true);
      },
    );
  }

  ThemeData _lightTheme() {
    return ThemeData.light().copyWith(
        primaryColor: Colors.lightGreen[400],
        accentColor: Colors.lightGreenAccent[400],
        appBarTheme: AppBarTheme(elevation: 0.0, color: Colors.lightGreen[400]),
        textTheme: TextTheme(
            body1: TextStyle(color: Colors.white),
            // body2: TextStyle(color: Colors.white),
            subhead: TextStyle(
                color: Color.fromARGB(255, 32, 32, 32),
                fontWeight: FontWeight.bold),
            subtitle: TextStyle(color: Color.fromARGB(255, 80, 80, 80))));
  }

  ThemeData _darkTheme() {
    return ThemeData.light().copyWith(
        // primaryColor: Colors.lightGreen[50],
        // appBarTheme: AppBarTheme(elevation: 0.0, color: Colors.lightGreen[300]),
        // textTheme: TextTheme(
        //     subhead: TextStyle(
        //         color: Color.fromARGB(255, 32, 32, 32),
        //         fontWeight: FontWeight.bold),
        //     subtitle: TextStyle(color: Color.fromARGB(255, 80, 80, 80)))
        );
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          MenuItem(text: "MENU", routeName: app.routeNameMenu, callback: _navigate),
          MenuItem(
              text: "ORDERS MANAGEMENT",
              routeName: app.routeNameOrdersManagement,
              callback: _navigate)
        ],
      ),
    );
  }

  void _navigate(String routeName) {
    print("route name: $routeName");
    Navigator.of(context).pushNamed(routeName);
  }
}

typedef void RouteNavigate(String routeName);

class MenuItem extends StatefulWidget {
  final String text;
  final String routeName;
  final RouteNavigate callback;
  bool isSelected;

  MenuItem({Key key, this.text, this.routeName, this.callback, this.isSelected})
      : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (widget.callback != null) {
            widget.callback(widget.routeName);
          }
        },
        child: Column(children: [
          SizedBox(height: 16.0),
          Text(widget.text),
          SizedBox(height: 5.0),
          Container(width: 100.0, height: 3.0, color: Colors.white)
        ]));
  }
}
