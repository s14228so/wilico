import 'package:flutter/material.dart';

import "./models/plan.dart";

class PlanDetail extends StatelessWidget {
  final Plan plan;

  const PlanDetail({Key key, @required this.plan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("プラン詳細")),
        body: Center(
          child: Text(
            ("プラン" + plan.index),
          ),
        ));
  }
}
