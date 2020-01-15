import 'package:flutter/material.dart';
import 'package:nishant/services/authentication.dart';
import 'package:nishant/shared/header.dart';
class Anonymous extends StatefulWidget {
  @override
  _AnonymousState createState() => _AnonymousState();
}

class _AnonymousState extends State<Anonymous> {
  Authentication _auth=Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(context,titleText: "Upload"),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('please login to upload blogs',style:TextStyle(
                      fontSize: 25
                    ),),
                    RaisedButton(
                      color: Colors.red,
                      onPressed:()=> _auth.signOut(),
                      child: Text('Login',style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
            ),
    );
  }
}