import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:nishant/services/authentication.dart';
import 'package:nishant/shared/loading.dart';

Authentication _auth = Authentication();
final _formKey = GlobalKey<FormState>();

class Login extends StatefulWidget {
  final Function toggleView;
  Login({this.toggleView});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  String err = '';
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Material(
            child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/1.jpg'),
                    fit: BoxFit.cover
                  ),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
                  child: new Container(
                    decoration:
                        new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
              ListView(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  _loginForm(context, widget.toggleView),
                ],
              ),
            ],
          ));
  }

//Getting user Infos
  Container _loginForm(BuildContext context, toggleView) {
    String email;
    String password;
    return Container(
      padding: EdgeInsets.all(20),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: RoundedDiagonalPathClipper(),
            child: Form(
              key: _formKey,
              child: Container(
                height: 500,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Colors.white.withOpacity(1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 90,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        validator: (val) =>
                            val.isEmpty ? "Email should not be empty" : null,
                        decoration: InputDecoration(
                            hintText: "Enter Email",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.email,
                              color: Colors.pink,
                            )),
                        onChanged: (val) => email = val,
                      ),
                    ),
                    Container(
                      child: Divider(
                        color: Colors.pink.shade400,
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        obscureText: true,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: "Enter Password",
                            hintStyle: TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: Colors.pink,
                            )),
                        onChanged: (val) => password = val,
                      ),
                    ),
                    Container(
                      child: Divider(
                        color: Colors.pink.shade400,
                      ),
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: RaisedButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    dynamic result = await _auth
                                        .userLoginWithUserName(email, password);
                                    if (result == null) {
                                      setState(() {
                                        err = "Invalid Credentials";
                                        isLoading = false;
                                      });
                                    }
                                  }
                                },
                                color: Colors.pink,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 10, bottom: 10),
                                  child: Text(
                                    'Login',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: RaisedButton(
                                onPressed: toggleView,
                                color: Colors.pink,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30, top: 10, bottom: 10),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '------   or   ------',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: RaisedButton(
                            onPressed: () async {
                              dynamic result = await _auth.signInAnon();
                            },
                            color: Colors.pink,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 10, bottom: 10),
                              child: Text(
                                'Skip',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    ),
                    Center(
                      child: Text(
                        err,
                        style: TextStyle(color: Colors.pink),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.pink.shade600,
                child: Image(
                  image: NetworkImage(
                      'https://www.logolynx.com/images/logolynx/15/1588b3eef9f1607d259c3f334b85ffd1.png'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
