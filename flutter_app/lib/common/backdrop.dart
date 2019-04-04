import 'package:flutter/material.dart';

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

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
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
