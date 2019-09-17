import 'package:flutter/material.dart';

class Online extends StatelessWidget {
  const Online({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("無料オンライン相談"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text("自分の課題がまだわからないそんなあなたに"),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0)),
            color: Color.fromRGBO(37, 178, 144, 1),
            child: Text("まずは試してみる", style: TextStyle(color: Colors.white)),
            onPressed: () {},
          )
        ],
      )),
    );
  }
}
