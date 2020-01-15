import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nishant/authenticate/authenticate.dart';
import 'package:nishant/authenticate/login.dart';
import 'package:nishant/modal/User.dart';
import 'package:nishant/screens/home.dart';
import 'package:nishant/services/authentication.dart';
import 'package:nishant/shared/loading.dart';
import 'package:provider/provider.dart';
class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user=Provider.of<User>(context);
    if(user==null){
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}