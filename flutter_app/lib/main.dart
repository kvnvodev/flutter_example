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
      initialRoute: app.routeNameHome,
      routes: {
        app.routeNameHome: (context) => HomePage(),
        app.routeNameOrdersManagement: (context) => OrdersManagementPage(),
        app.routeNameMenu: (context) => MenuPage()
      }
    );
  }
}
