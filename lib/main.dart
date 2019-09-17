import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wilico/pages/mypage.dart';
import './plan_detail.dart';
import "models/plan.dart";
import 'online.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      theme: ThemeData(primaryColor: Colors.white, primarySwatch: Colors.red),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var count = 1;
  var title = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wilico',
              style: TextStyle(
                fontFamily: "MainTitle",
                fontWeight: FontWeight.w800,
              )),
          centerTitle: true,
          leading: Icon(Icons.search),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('プランを探す'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timeline),
              title: Text('タイムライン'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('トーク'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('マイページ'),
            ),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.amber[800],
          onTap: null,
        ),
        body: Column(
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
                    child: Text("無料オンライン相談へ",
                        style: TextStyle(color: Colors.white)),
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
        ),
        endDrawer: Drawer(
            child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                accountName: Text("Ashish Rawat"),
                accountEmail: Text("ashishrawat2911@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.white
                          : Colors.white,
                  child: Icon(
                    Icons.person,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('マイページ'),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyPage()),
                );
              },
            ),
            ListTile(
              title: Text('プラン一覧'),
              trailing: Icon(Icons.list),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('ログアウト'),
              trailing: Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        )));
  }

  createListView() {
    return StreamBuilder(
        stream: Firestore.instance.collection('plans').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // エラーの場合
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
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: List.generate(snapshot.data.documents.length,
                          (index) {
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
                                                image: new NetworkImage("")))),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      snapshot.data.documents[index]["title"],
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
                                        "おちんちんコース ${index + 1}",
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
                                        child:
                                            Text("${(index + 1) * 1000}円/月")),
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
}
