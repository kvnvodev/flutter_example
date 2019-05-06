import 'package:flutter/material.dart';

import 'package:planning_poker/pages/login_page.dart';
import 'package:planning_poker/pages/home_page.dart';
import 'package:planning_poker/pages/chat_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  P2HomePage _homePage;

  MyApp() {
    _homePage = P2HomePage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme:
                TextTheme().copyWith(body1: TextStyle(color: Colors.white))),
        // home: _homePage,
        home: P2ChatPage(),
        navigatorObservers: <NavigatorObserver>[_homePage],
        initialRoute: "/login",
        onGenerateRoute: (RouteSettings settings) {
          if (settings.name != "/login") {
            return null;
          }

          return MaterialPageRoute(
              fullscreenDialog: true,
              settings: settings,
              builder: (BuildContext context) => P2LoginPage());
        });
  }
}
