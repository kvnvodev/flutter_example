import 'package:flutter/material.dart';
import 'package:flutter_app/pages/main_page.dart';
import 'package:flutter_app/pages/login_page.dart';

void main() {
  // Do something before run app

  // start main
  runApp(SPSpaApp());
}

class SPSpaApp extends StatelessWidget {
  // Map<String, (BuildContext) -> Widget> _routes = {};
  final Map<String, dynamic> _routes = {
    "/login": (BuildContext context) => SPLoginPage()
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SPMainPage(),
      // routes: _routes,
      onGenerateRoute: (RouteSettings settings) {
        bool fullscreen = false;
        if (settings.name == "/login") {
          fullscreen = true;
        }

        return MaterialPageRoute(
            fullscreenDialog: fullscreen,
            settings: settings,
            builder: _routes[settings.name]);
      },
    );
  }
}
