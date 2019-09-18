import 'package:flutter/material.dart';
import 'package:wilico/pages/mypage.dart';
import "./pages/home.dart";
import "./pages/login.dart";

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
  int _index = 0;
  bool isAuth = false;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
          items: isAuth
              ? const <BottomNavigationBarItem>[
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
                ]
              : const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.timeline),
                    title: Text('タイムライン'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    title: Text('ログイン'),
                  ),
                ],
          currentIndex: 0,
          selectedItemColor: Colors.amber[800],
          onTap: (int index) {
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 10), curve: Curves.ease);
          },
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() {
              this._index = index;
            });
          },
          children: <Widget>[
            new Home(),
            new MyPage(),
            new Login(),
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
}
