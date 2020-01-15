import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isSignpage=true;
  void toggleView()
  {
    setState(() => isSignpage = !isSignpage);
  }
  @override
  Widget build(BuildContext context) {
    if(isSignpage)
    {
      return Login(toggleView:toggleView);
    }else{
      return Signup(toggleView:toggleView);
    }

  }
}