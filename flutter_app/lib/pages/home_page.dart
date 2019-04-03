import 'package:flutter/material.dart';

import 'package:flutter_app/utils/app_constants.dart' as app;

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   _appBar() {
//     return AppBar(
//       backgroundColor: Colors.amber,
//       title: Text("Demo App"),
//     );
//   }

//   Widget _newBody() {
//     return LayoutBuilder(builder: (context, constraints) {
//       return Backdrop();
//     });
//   }

//   _body() {
//     return Padding(
//       padding: const EdgeInsets.all(app.defaultSpacing),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: <Widget>[
//         //   Expanded(
//         //     flex: 1,
//         //     child: _HomeCard(
//         //       onTap: () {
//         //         _navigateTo(routeName: app.routeNameMenu);
//         //       },
//         //       child: Center(child: Text("Menu")),
//         //     ),
//         //   ),
//         //   SizedBox(height: app.defaultSpacing),
//         //   Expanded(
//         //     flex: 1,
//         //     child: _HomeCard(
//         //       onTap: () {
//         //         _navigateTo(routeName: app.routeNameOrdersManagement);
//         //       },
//         //       child: Center(child: Text("Orders Management")),
//         //     ),
//         //   ),
//         // ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _appBar(),
//       body: _newBody(),
//     );
//   }

//   void _navigateTo({routeName: String}) {
//     Navigator.of(context).pushNamed(routeName);
//   }
// }

// class _HomeCard extends StatelessWidget {
//   final Widget child;
//   final Function onTap;

//   _HomeCard({Key key, this.child, this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: app.defaultCardElevation,
//         borderOnForeground: false,
//         margin: const EdgeInsets.all(0.0),
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(app.defaultCardRadius)),
//         color: Colors.lightGreen[100],
//         child: child,
//       ),
//     );
//   }
// }

class Backdrop extends StatefulWidget {
  final Widget backLayer;
  final Widget frontLayer;

  const Backdrop({this.backLayer, this.frontLayer});

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  Widget _appBar() {
    return AppBar(
      leading: IconButton(
          icon: AnimatedIcon(
              icon: AnimatedIcons.menu_close, progress: animationController),
          onPressed: () {
            if (animationController.status == AnimationStatus.dismissed ||
                animationController.status == AnimationStatus.forward) {
              // animationController.forward();
              animationController.fling(velocity: 3.0);
            } else {
              animationController.fling(velocity: -3.0);
              // animationController.reverse();
            }
            // setState(() {});
          }),
      title: Text("Demo App"),
    );
  }

  Widget _body() {
    return LayoutBuilder(builder: (context, constraints) {
      const double layerTitleHeight = 50.0;
      final Size layerSize = constraints.biggest;
      final double layerTop = layerSize.height - layerTitleHeight;

      Animation<RelativeRect> layerAnimation = RelativeRectTween(
        begin: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
        end: RelativeRect.fromLTRB(
            0.0, layerTop, 0.0, layerTop - layerSize.height),
      ).animate(animationController.view);

      return Stack(
        children: <Widget>[
          Container(
              color: Theme.of(context).appBarTheme.color,
              height: constraints.biggest.height,
              width: constraints.biggest.width,
              child: widget.backLayer),
          PositionedTransition(
            rect: layerAnimation,
            child: Material(
                color: Colors.white,
                elevation: 16.0,
                shape: BeveledRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(50.0))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(height: 50),
                    Expanded(
                        child: Container(
                            color: Colors.white, child: widget.frontLayer))
                  ],
                )),
          ),
        ],
      );
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
