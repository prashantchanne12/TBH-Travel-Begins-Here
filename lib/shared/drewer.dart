import 'package:flutter/material.dart';
import 'package:nishant/screens/upload.dart';

drawer(context){
  return Drawer(
              child:ListView(children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red
              ),
            accountName: Text("Ashish Rawat"),
            accountEmail: Text("ashishrawat2911@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor:
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? Colors.blue
                      : Colors.white,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
            ListTile(
              title: Text('Upload'),
              onTap:()=>Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Upload(),
            )),
            ),
    ],
    )
  );
}