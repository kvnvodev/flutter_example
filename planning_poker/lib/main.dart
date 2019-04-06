import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        // theme: ThemeData(
        //     textTheme: TextTheme().copyWith(button: TextStyle(color: Colors.cyan)),
        //     buttonTheme: ButtonThemeData().copyWith(
        //         buttonColor: Colors.amber),
        //     inputDecorationTheme:
        //         InputDecorationTheme(border: OutlineInputBorder())),
        home: P2HomePage(),
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

class P2LoginPage extends StatefulWidget {
  @override
  _P2LoginPageState createState() => _P2LoginPageState();
}

class _P2LoginPageState extends State<P2LoginPage> {
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _cancelLogin() {
    Navigator.of(context).pop();
  }

  void _login() {
    if (_usernameController.text == "admin" &&
        _passwordController.text == "admin") {}

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // padding: const EdgeInsets.all(16.0),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            Container(height: 200.0, color: Theme.of(context).primaryColor),
            const SizedBox(height: 16.0),
            TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                    labelText: "Username", hintText: "Username")),
            const SizedBox(height: 16.0),
            TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                    labelText: "Password", hintText: "Password"),
                obscureText: true),
            const SizedBox(height: 16.0),
            ButtonBar(children: [
              FlatButton(onPressed: _cancelLogin, child: Text("Cancel")),
              RaisedButton(
                onPressed: _login,
                child: Text("Login"),
              )
            ]),
            FlatButton(onPressed: () {}, child: Text("Forgot password"))
          ],
        ),
      ),
    );
  }
}

class P2HomePage extends StatefulWidget {
  @override
  _P2HomePageState createState() => _P2HomePageState();
}

class _P2HomePageState extends State<P2HomePage> with TickerProviderStateMixin {
  int val = 8;
  Axis direction = Axis.vertical;
  double fraction = 0.5;
  PageController pageController;

  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    direction = Axis.vertical;
    fraction = 0.5;
    pageController = PageController(viewportFraction: fraction);
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
  }

  @override
  Widget build(BuildContext context) {
    int count = 3;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double width = constraints.biggest.width;
      double height = constraints.biggest.height / count;

      List<Widget> list = List<Widget>.generate(count, (int index) {
        double top = index * height;
        Animation<RelativeRect> anim = animationController
            .drive(CurveTween(curve: Curves.easeIn))
            .drive(RelativeRectTween(
                begin: RelativeRect.fromLTRB(0, 0, 0, 0),
                end: RelativeRect.fromLTRB(0, -top, 0, top)));

        return Expanded(
            child: Stack(overflow: Overflow.visible, children: <Widget>[
          PositionedTransition(
              rect: anim,
              child: Container(
                  width: width,
                  height: height,
                  color: [Colors.blue, Colors.yellow, Colors.green][index]))
        ]));
      });

      return GestureDetector(
        onTap: () {
          if (animationController.status == AnimationStatus.dismissed ||
              animationController.status == AnimationStatus.forward) {
            animationController.forward();
          } else {
            animationController.reverse();
          }
        },
        child: Column(
          children: list,
        ),
      );
    });
  }

  Widget build1(BuildContext context) {
    int count = 3;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double width = constraints.biggest.width;
      double height = constraints.biggest.height / count;

      List<Widget> list = List<Widget>.generate(count, (int index) {
        double top = index * height;

        // Animation<RelativeRect> anim = RelativeRectTween(
        //         begin: RelativeRect.fromLTRB(0, 0, 0, 0),
        //         end: RelativeRect.fromLTRB(0, -top, 0, top - height))
        //     .animate(animationController);
        Animation<RelativeRect> anim = animationController
            .drive(CurveTween(curve: Curves.easeIn))
            .drive(RelativeRectTween(
                begin: RelativeRect.fromLTRB(0, 0, 0, 0),
                end: RelativeRect.fromLTRB(0, -top, 0, top)));

        Animation<Rect> anim1 = animationController
            .drive(CurveTween(curve: Curves.easeIn))
            .drive(RectTween(
                begin: Rect.fromLTWH(0, top, width, height),
                end: Rect.fromLTWH(index * width, 0, width, height)));

        return RelativePositionedTransition(
            size: Size(0, 0),
            rect: anim1,
            child: Container(
                width: width,
                height: height,
                color: [Colors.blue, Colors.yellow, Colors.green][index]));

        // return Positioned(
        //   left: 0,
        //   top: top,
        //   width: width,
        //   height: height,
        //   child: Stack(
        //     overflow: Overflow.visible,
        //     children: [
        //       PositionedTransition(
        //         rect: anim,
        //         child: Container(
        //             color: [Colors.blue, Colors.yellow, Colors.green][index]),
        //       )
        //     ],
        //   ),
        // );
      });

      list.add(RaisedButton(
          onPressed: () {
            if (animationController.status == AnimationStatus.dismissed ||
                animationController.status == AnimationStatus.forward) {
              animationController.forward();
            } else {
              animationController.reverse();
            }
          },
          child: Text("animate")));

      return Stack(
        // overflow: Overflow.visible,
        children: list,
      );

      // return Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: <Widget>[
      //     Expanded(
      //         child: Container(
      //       color: Colors.green,
      //     )),
      //     Expanded(
      //         child: Container(
      //       color: Colors.yellow,
      //       child: Stack(children: <Widget>[
      //         PositionedTransition(
      //           rect: anim,
      //           child: Container(
      //             color: Colors.blue,
      //           ),
      //         ),
      //         RaisedButton(
      //           onPressed: () {
      //             animationController.forward();
      //           },
      //           child: Text("click"),
      //         )
      //       ]),
      //     )),
      //   ],
      // );

      // return Stack(
      //   children: [
      //     PositionedTransition(
      //       rect: anim,
      //       child: Container(
      //         color: Colors.blue,
      //       ),
      //     ),
      //     RaisedButton(
      //       onPressed: () {
      //         animationController.forward();
      //       },
      //       child: Text("click"),
      //     )
      //   ],
      // );
    });

    // // RelativeRect
    // return Stack(
    //   children: <Widget>[
    //     PositionedTransition(
    //         rect: anim,
    //         child: PageView(
    //           scrollDirection: direction,
    //           controller: pageController,
    //           pageSnapping: false,
    //           children: <Widget>[
    //             Container(color: Colors.red),
    //             Container(color: Colors.green),
    //             Container(color: Colors.blue)
    //           ],
    //         )),
    //     // LayoutBuilder(
    //     //     builder: (BuildContext context, BoxConstraints constraints) {
    //     //   return Container(
    //     //       height: constraints.biggest.height * fraction,
    //     //       child: PageView(
    //     //         scrollDirection: direction,
    //     //         controller: pageController,
    //     //         pageSnapping: false,
    //     //         children: <Widget>[
    //     //           Container(color: Colors.red),
    //     //           Container(color: Colors.green),
    //     //           Container(color: Colors.blue)
    //     //         ],
    //     //       ));
    //     // }),

    //     // PageView(
    //     //   scrollDirection: direction,
    //     //   controller: pageController,
    //     //   pageSnapping: false,
    //     //   children: <Widget>[
    //     //     Container(color: Colors.red),
    //     //     Container(color: Colors.green),
    //     //     Container(color: Colors.blue)
    //     //   ],
    //     // ),

    //     // AnimatedPadding(
    //     //   padding: EdgeInsets.all(val.toDouble()),
    //     //   duration: Duration(milliseconds: 3000),
    //     //   child: PageView(
    //     //     scrollDirection: Axis.horizontal,
    //     //     children: <Widget>[
    //     //       Container(color: Colors.red),
    //     //       Container(color: Colors.green),
    //     //       Container(color: Colors.blue)
    //     //     ],
    //     //   ),
    //     // ),
    //     RaisedButton(
    //         onPressed: () {
    //           setState(() {
    //             // val = (val + 8) % 80;
    //             if (direction == Axis.vertical) {
    //               direction = Axis.horizontal;
    //               fraction = 1.0;
    //             } else {
    //               direction = Axis.vertical;
    //               fraction = 0.5;
    //             }
    //             pageController = PageController(viewportFraction: fraction);
    //           });
    //         },
    //         child: Text("reload"))
    //   ],
    // );
  }
}

class HomePage extends StatefulWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter;
  List<String> data = List<String>.generate(100, (int index) {
    return "Line Line Line Line Line Line Line Line Line Line 99999 9 9 9 99 9 9 9 9 9 9 9 9 9 9  9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 9 99 9 9 9 9 9 99 9 9 9 9 9 9 9: ${index + 1}";
  });

  @override
  void initState() {
    super.initState();
    _counter = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    return Container(
                        height: constraints.biggest.width,
                        child: PageView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(color: Colors.red),
                            Container(color: Colors.green),
                            Container(color: Colors.blue)
                          ],
                        ));
                    return Container(
                        height: constraints.biggest.width,
                        child: GridView.builder(
                            padding: const EdgeInsets.all(8.0),
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisSpacing: 8.0,
                                    crossAxisSpacing: 8.0,
                                    crossAxisCount: _counter),
                            itemCount: 4,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(color: Colors.amber);
                            }));
                  });
                }
                String text = data[index];
                return GestureDetector(
                    onTap: () {
                      print("tap index: $index");
                    },
                    child: Text(index % 2 == 0 ? text : "short"));
              })),
    );
  }
}
