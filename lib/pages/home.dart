import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../online.dart';
import '../plan_detail.dart';
import "../models/plan.dart";

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);
  createListView() {
    return StreamBuilder(
        stream: Firestore.instance.collection('plans').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // エラーの場合
          final openLists = snapshot.data.documents
              .where((data) => data["open"] == true)
              .toList();
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading ...');
            default:
              return Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                  child: GridView.count(
                      childAspectRatio: 0.65,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: List.generate(openLists.length, (index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlanDetail(
                                      plan: new Plan((index + 1).toString())),
                                ),
                              );
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Container(
                                        width: 100.0,
                                        height: 100.0,
                                        margin: EdgeInsets.only(top: 20.0),
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              width: 2,
                                              color: Color.fromRGBO(
                                                  37, 178, 144, 1),
                                            ),
                                            image: new DecorationImage(
                                                fit: BoxFit.cover,
                                                image: new NetworkImage(snapshot
                                                        .data.documents[index]
                                                    ["coach"]["profileImg"])))),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      "${snapshot.data.documents[index]["coach"]["username"]}コーチ",
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${snapshot.data.documents[index]["title"]}コース",
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            "${snapshot.data.documents[index]["price"]}円")),
                                    Wrap(
                                      // alignment: WrapAlignment.start,
                                      spacing:
                                          2.0, // gap between adjacent chips
                                      direction:
                                          Axis.horizontal, // gap between lines
                                      children: <Widget>[
                                        Container(
                                          child: Chip(
                                            label: Text(
                                              'Hamilton',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color.fromRGBO(
                                                    37, 178, 144, 1),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Chip(
                                            label: Text(
                                              'Hamilton',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color.fromRGBO(
                                                    37, 178, 144, 1),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      })));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Expanded(
            flex: 1,
            child: Container(
              width: 250,
              margin: EdgeInsets.symmetric(vertical: 20),
              child: RaisedButton(
                color: Colors.orangeAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0)),
                child:
                    Text("無料オンライン相談へ", style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Online()),
                  );
                },
              ),
            )),
        new Expanded(flex: 6, child: createListView()),
      ],
    );
  }
}
