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
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('plans').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // エラーの場合
          if (!snapshot.hasData) {
            return const Text('Loading...');
          } else {
            List openLists = snapshot.data.documents
                .where((listData) => listData.data["open"] == true)
                .toList();

            // snapshot.data.documents.length > 0  ?
            return Container(
                padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
                child: GridView.count(
                    childAspectRatio: 0.48,
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
                                            color:
                                                Color.fromRGBO(37, 178, 144, 1),
                                          ),
                                          image: new DecorationImage(
                                              fit: BoxFit.cover,
                                              image: new NetworkImage(snapshot
                                                      .data
                                                      .documents[index]
                                                      .data["coach"]
                                                  ["profileImg"])))),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "${snapshot.data.documents[index].data["coach"]["username"]}コーチ",
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
                                      "${snapshot.data.documents[index].data["title"]}コース",
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
                                          "${snapshot.data.documents[index].data["price"]}円")),
                                  Wrap(
                                      // alignment: WrapAlignment.start,
                                      spacing:
                                          2.0, // gap between adjacent chips
                                      direction:
                                          Axis.horizontal, // gap between lines
                                      children: snapshot
                                          .data.documents[index].data["tags"]
                                          .map<Widget>((tag) {
                                        return Container(
                                          child: Chip(
                                            label: Text(
                                              '$tag',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Color.fromRGBO(
                                                    37, 178, 144, 1),
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList())
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
