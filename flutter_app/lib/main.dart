import 'package:flutter/material.dart';

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
      initialRoute: "/home",
      onGenerateRoute: (settings) {
        final routes = {
          app.routeNameHome: (context) => HomePage(),
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
