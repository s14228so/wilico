import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './plan_detail.dart';
import "models/plan.dart";

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
        body: createListView(),
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
                Navigator.pop(context);
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

  Widget createListView() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    final String img =
        "https://firebasestorage.googleapis.com/v0/b/coach-59f10.appspot.com/o/images%2FIMG_5557.JPG?alt=media&token=88c67509-37cb-4457-8871-55b9a91a0963";
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
      margin: EdgeInsets.only(top: 30.0),
      child: GridView.count(
        mainAxisSpacing: 20,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        crossAxisCount: 2,
        children: List.generate(8, (index) {
          return Container(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PlanDetail(plan: new Plan((index + 1).toString())),
                  ),
                );
              },
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Container(
                        width: 100.0,
                        height: 100.0,
                        margin: EdgeInsets.only(top: 20.0),
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                                fit: BoxFit.cover,
                                image: new NetworkImage(img)))),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "冨迫孔聡コーチ",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "コース ${index + 1}",
                      style: TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text("${(index + 1) * 1000}円/月"),
                    Wrap(
                      // alignment: WrapAlignment.start,
                      spacing: 2.0, // gap between adjacent chips
                      direction: Axis.horizontal, // gap between lines
                      children: <Widget>[
                        Container(
                          child: Chip(
                            label: Text(
                              'Hamilton',
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ),
                        ),
                        Container(
                          child: Chip(
                            label: Text(
                              'Hamilton',
                              style: TextStyle(fontSize: 10.0),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
