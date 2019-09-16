import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Input extends StatefulWidget {
  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  var title = "";
  TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (v) => setState(() {
                title = v;
              }),
              decoration: InputDecoration(
                hintText: "add title",
              ),
            ),
          ),
        ),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(0),
              child: RaisedButton(
                child: Text('Submit'),
                onPressed: () => addItem(title),
              ),
            )),
      ],
    );
  }

  Future<void> addItem(String title) {
    Firestore.instance.collection('test').add({
      'title': title,
      'body': '著者',
    });
    setState(() {
      title = "";
      print(title);
    });
    return null;
  }
}
