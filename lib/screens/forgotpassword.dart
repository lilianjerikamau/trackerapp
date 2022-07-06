import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:trackerapp/main.dart';
import 'package:trackerapp/models/usermodels.dart';
import 'package:trackerapp/screens/verifyemail.dart';
import 'package:trackerapp/utils/config.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:query_params/query_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckUser extends StatefulWidget {
  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> with RouteAware {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _usernameController = new TextEditingController();
  GlobalKey<FormState> _formKey = new GlobalKey();
  late BuildContext _context;
  bool _userVerified = false;
  late String userEmail;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    _checkUpdated();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return WillPopScope(
      onWillPop: () async {
        if (_userVerified) {
          setState(() {
            _userVerified = false;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Forgot Password')),
        body: _userVerified
            ? VerifyEmail(_context)
            : Container(
                color: Colors.white70,
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                              'Enter your username and email combination in the inputs below to verify your account',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.black))),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _usernameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your username';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide()),
                                labelText: 'Username'),
                          )),
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Specify your email';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide()),
                                labelText: 'Email'),
                          )),
                      Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CupertinoButton(
                              color: Colors.red,
                              child: Text('Check user'),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ProgressDialog di =
                                      new ProgressDialog(context);
                                  di.style(message: 'Checking user ... ');
                                  di.show();
                                  String username =
                                      _usernameController.text.trim();
                                  String email = _emailController.text.trim();
                                  URLQueryParams qp = new URLQueryParams();
                                  qp.append('username', username);
                                  qp.append('email', email);
                                  String url = await getBaseUrl();
                                  HttpClientResponse? rsp =
                                      await getRequestObject(
                                          url +
                                              'mobileuser/checkUser?' +
                                              qp.toString(),
                                          get,
                                          dialog: di);
                                  if (rsp != null) {
                                    rsp.transform(utf8.decoder).listen((data) {
                                      print(data);
                                      // var jsonResponse = json.decode(data);
                                      if (data != null) {
                                        User user =
                                            User.fromJson(json.decode(data));
                                        if (user.id! > 0) {
                                          SessionPreferences()
                                              .setLoggedInUser(user)
                                              .then((x) {
                                            setState(() {
                                              _userVerified = true;
                                            });
                                          });
                                        } else {
                                          showDialog(
                                              context: _context,
                                              builder: (BuildContext bc) {
                                                return CupertinoAlertDialog(
                                                  title: Text(
                                                      'Account Action Needed'),
                                                  content: Text(
                                                      'Your user account username is not Available'),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                        onPressed: () {
                                                          Navigator.pop(bc);
                                                        },
                                                        child: Text('Ok'))
                                                  ],
                                                );
                                              });
                                        }
                                      }
                                    });
                                  }
                                }
                              }))
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  void _checkUpdated() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool? updated = sharedPreferences.getBool('updated');
    if (updated != null && updated) {
      sharedPreferences.setBool('fromFgPass', true);
      Navigator.pop(_context);
    }
  }
}
