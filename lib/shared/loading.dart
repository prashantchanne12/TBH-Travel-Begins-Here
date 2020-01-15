
import 'dart:ui';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> images=[
 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTkCgdoQ9Qmz3vctd6saYaLhj--6MjY_a1jJas19fYdI432aAl-',
  'https://www.sumantravels.com/wp-content/uploads/2019/09/istockphoto-494659822-612x612.jpg',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSd9v5kBCQP5TM-T-S9Cgg1YpvJnYMCE5Rfk0pKDLUdDJ_cyYaj'
    ];
String index=(images..shuffle()).first;
    return Stack(
      children: <Widget>[
         Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: NetworkImage(index),
        //   fit: BoxFit.cover
        //   ),
        // ),
        //  child: BackdropFilter(
        //      filter: ImageFilter.blur(sigmaX:5.0, sigmaY:5.0),
        //         child: new Container(
        //           decoration: new BoxDecoration(color: Colors.black.withOpacity(0.5)),
        //         ),
        //   ),
        color: Colors.red[100],
      ),Center(
          child: SpinKitWave(
            color: Colors.red,
            size: 60,

            ),
        ),
      ],
    );
  }
}