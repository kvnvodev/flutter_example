import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class P2HomePage extends StatefulWidget with NavigatorObserver {
  @override
  _P2HomePageState createState() => _P2HomePageState();

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (previousRoute != null && route != null) {
      print("push: ${previousRoute.settings.name} -> ${route.settings.name}");
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    if (previousRoute != null && route != null) {
      print("pop: ${route.settings.name} -> ${previousRoute.settings.name}");
    }
  }
}

enum GridType { list, grid }

class _P2HomePageState extends State<P2HomePage> with TickerProviderStateMixin {
  GridType _gridType;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _gridType = GridType.list;
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildBody());
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text("Planning Poker"),
      actions: [
        IconButton(
            icon: AnimatedIcon(
                icon: AnimatedIcons.view_list,
                progress: CurvedAnimation(
                    parent: _animationController, curve: Curves.easeIn)),
            onPressed: () {
              if (_animationController.status == AnimationStatus.forward ||
                  _animationController.status == AnimationStatus.dismissed) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }

              setState(() {
                if (_gridType == GridType.list) {
                  _gridType = GridType.grid;
                } else {
                  _gridType = GridType.list;
                }
              });
            })
      ],
    );
  }

  Column _buildBody() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      UserInfo(),
      Flexible(
        child: _buildStreamData(),
      )
    ]);
  }

  StreamBuilder<QuerySnapshot> _buildStreamData() {
    return StreamBuilder(
      stream: Firestore.instance.collection("projects").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return _buildListData(snapshot);
      },
    );
  }

  LayoutBuilder _buildListData(AsyncSnapshot<QuerySnapshot> snapshot) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        int numCols = 1;
        if (_gridType == GridType.grid) {
          numCols = 2;
        }

        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildRowData(
                    index, constraints, snapshot.data.documents[index]),
                color: Theme.of(context).primaryColor,
              );
            });
      },
    );
  }

  Column _buildRowData(
      int index, BoxConstraints constraints, DocumentSnapshot document) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(color: Colors.white, height: index != 0 ? 16.0 : 0.0),
      Image.asset("assets/images/flutter-rounded-icon.png",
          fit: BoxFit.cover,
          width: constraints.biggest.width,
          height: constraints.biggest.width * 9 / 16),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          document["name"],
        ),
      ),
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Icon(Icons.account_circle, color: Colors.white),
        Text(
          document["votes"].toString(),
        ),
        Icon(Icons.alarm, color: Colors.white),
        Text(document["votes"].toString())
      ])
    ]);
  }
}

class GridData extends StatelessWidget {
  final List<DocumentSnapshot> projects;
  final int numCols;
  final double gridWidth;

  const GridData({this.projects, this.numCols, this.gridWidth});

  @override
  Widget build(BuildContext context) {
    double width = (gridWidth - (numCols + 1) * 16.0) / numCols;
    double ratio = width / (width + 80.0);

    if (numCols == 1) {
      ratio = 16.0 / 9.0;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: projects.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              child: Container(
                child: numCols != 1
                    ? GridItem(document: projects[index])
                    : ListItem(document: projects[index]),
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                projects[index]
                    .reference
                    .updateData({"votes": projects[index]["votes"] + 1});
              });
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            crossAxisCount: numCols,
            childAspectRatio: ratio),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
          children: [CircleAvatar(), SizedBox(width: 16), Text("username")]),
    );
  }
}

class ListItem extends StatelessWidget {
  final DocumentSnapshot document;
  const ListItem({this.document});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset("assets/images/flutter-rounded-icon.png",
              fit: BoxFit.cover,
              width: constraints.biggest.width,
              height: constraints.biggest.height * 2 / 3),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text(document["name"], maxLines: 2)),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        child: Text(document["votes"].toString(),
                            style:
                                TextStyle(color: Colors.black, fontSize: 20.0)),
                        color: Colors.white),
                  ],
                )
              ],
            ),
          ))
        ],
      );
    });
  }
}

class GridItem extends StatelessWidget {
  final DocumentSnapshot document;
  const GridItem({this.document});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset("assets/images/flutter-rounded-icon.png",
              fit: BoxFit.fill),
          SizedBox(height: 8.0),
          Text(document["name"], maxLines: 3)
        ],
      ),
    );
  }
}
