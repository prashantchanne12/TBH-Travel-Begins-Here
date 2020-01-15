import 'package:flutter/material.dart';
import 'package:nishant/shared/header.dart';
class Nearby extends StatefulWidget {
  @override
  _NearbyState createState() => _NearbyState();
}

class _NearbyState extends State<Nearby> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,titleText: "Nearby"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text('NearBy'),
          )
        ],
      ),
    );
  }
}