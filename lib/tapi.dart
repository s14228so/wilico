import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Tapi extends StatefulWidget {
  @override
  _TapiListState createState() => _TapiListState();
}

class _TapiListState extends State<Tapi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.redAccent,
        appBar: AppBar(
          title: Text('Flutter Firestore Demo'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: createListView(),
            ),
            Expanded(
                flex: 1,
                child: RaisedButton(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 30),
                      Icon(Icons.arrow_back),
                      Text("戻る"),
                    ],
                  ),
                  onPressed: () => Navigator.pop(context),
                )),
            // Expanded(
            //   flex: 3,
            //   child: Container(),
            // )
          ],
        ));
  }

  Widget buildImage(data) {
    print(data["title"]);
    return Column(
      children: <Widget>[
        Card(
          child: Container(
              margin: const EdgeInsets.all(10.0),
              width: 150,
              child: Column(
                children: <Widget>[
                  Image.network(
                    data["image"],
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Text(data["title"])
                ],
              )),
        ),
      ],
    );
  }

  createListView() {
    return StreamBuilder(
      stream: Firestore.instance.collection('tapi').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // エラーの場合
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        // 通信中の場合
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text('Loading ...');
          default:
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, int index) {
                return buildImage(snapshot.data.documents[index]);
              },
            );
        }
      },
    );
  }
}
