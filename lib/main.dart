

import 'package:flutter/material.dart';
import 'package:nishant/firebase/food_notifier.dart';
import 'package:nishant/firebase/ngo_notifier.dart';
import 'package:nishant/modal/User.dart';
import 'package:nishant/services/authentication.dart';
import 'package:nishant/wrapper.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
     create: (BuildContext context)=>FoodNotifier(),
    ),
   ChangeNotifierProvider(
     create: (BuildContext context)=>NgoNotifier(),
    ),
  
],
  child:MyApp(),
  ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
        return StreamProvider<User>.value(value:Authentication().user,
        child:MaterialApp(
          home: Wrapper(),
        )
        );
   }
}