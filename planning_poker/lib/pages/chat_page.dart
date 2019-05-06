import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class P2ChatPage extends StatefulWidget {
  @override
  _P2ChatPageState createState() => _P2ChatPageState();
}

class _P2ChatPageState extends State<P2ChatPage> {
  TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _streamBuilder()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: TextField(controller: _textController)),
              IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    send(_textController.text);
                    _textController.clear();
                  })
            ],
          )
        ],
      ),
    );
  }

  void send(String content) {
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentReference documentReference = await Firestore.instance
          .collection("chat")
          .add({"sender": "", "content": ""});
      await tx.set(documentReference, {"sender": "admin", "content": content});
    });
  }

  StreamBuilder<QuerySnapshot> _streamBuilder() {
    return StreamBuilder(
      stream: Firestore.instance.collection("chat").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final data = snapshot.data.documents;
        final children = data.reversed.map((document) {
          return ChatRecord(document: document);
        }).toList();

        return ListView(
          reverse: true,
          children: children,
        );

        // return ListView.builder(
        //     reverse: true,
        //     itemCount: data.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       final record = data[index];
        //       return Column(
        //           crossAxisAlignment: CrossAxisAlignment.end,
        //           children: [
        //             Text(record["sender"],
        //                 style: TextStyle(color: Colors.black)),
        //             Text(record["content"],
        //                 style: TextStyle(color: Colors.black))
        //           ]);
        //     });
      },
    );
  }
}

class ChatRecord extends StatelessWidget {
  final DocumentSnapshot document;

  const ChatRecord({this.document});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(color: Colors.green, width: 50, height: 50),
      ],
    );
    return LayoutBuilder(builder: (ctx, constraints) {
      print("${constraints.biggest.width}");
      return SizedBox(
          width: constraints.biggest.width / 3,
          child:
              // return
              Container(
            color: Theme.of(context).primaryColor,
            width: constraints.biggest.width / 3,
            height: 40,
            // child: Column(
            //     mainAxisSize: MainAxisSize.min,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(document["sender"], style: TextStyle(color: Colors.black)),
            //       Text(document["content"], style: TextStyle(color: Colors.black))
            //     ])
          ));
      // ;
    });
  }
}
