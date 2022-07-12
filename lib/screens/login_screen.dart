// ignore_for_file: unnecessary_const

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:query_params/query_params.dart';
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:trackerapp/models/usermodels.dart';
import 'package:trackerapp/screens/forgotpassword.dart';
import 'package:trackerapp/screens/home.dart';
import 'package:trackerapp/screens/selectcompany.dart';
import 'package:trackerapp/screens/tabs/tabspage.dart';
import 'package:trackerapp/utils/config.dart' as Config;
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoginPage> {
  // TextEditingController nameController = TextEditingController();
  // TextEditingController passwordController = TextEditingController();
  final _userNameInput = TextEditingController();
  final _passWordInput = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  late BuildContext _context;
  late User _loggedInUser;

  late bool _loggedIn = false,
      _loggingIn = false,
      _companySettingsDone = true,
      _showPass = true;
  late String _imgFromSettings;

  @override
  void initState() {
    // TODO: implement initState
    SessionPreferences().getCompanySettings().then((settings) {
      if (settings.baseUrl != null) {
        setState(() {
          _companySettingsDone = true;
        });
      } else {
        setState(() {
          _companySettingsDone = false;
        });
      }
      if (_companySettingsDone = false) {
        return ChooseCompany((imgName) {
          setState(() {
            _imgFromSettings = imgName;
            _companySettingsDone = true;
          });
        });
      } else {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_companySettingsDone != null) {
      if (_companySettingsDone = true) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Anchor Tracking'),
              backgroundColor: Colors.red,
              automaticallyImplyLeading: false,
            ),
            body: Form(
              key: _loginFormKey,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView(
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'images/logo.png',
                              height: 150.0,
                              width: 100.0,
                            ),
                          )),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          controller: _userNameInput,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'User Name',
                              focusColor: Colors.red),
                          validator: (value) =>
                              value!.isEmpty ? "This field is required" : null,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: TextFormField(
                          obscureText: true,
                          controller: _passWordInput,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              focusColor: Colors.red),
                          validator: (value) =>
                              value!.isEmpty ? "This field is required" : null,
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (ctx) => CheckUser()),
                          );
                        },
                        textColor: Colors.red,
                        child: const Text('Forgot Password'),
                      ),
                      Padding(
                          //  padding: EdgeInsets.all(20.0),
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: CupertinoButton(
                            color: Colors.red,
                            child: _loggingIn
                                ? Container(
                                    child: const CircularProgressIndicator(
                                        backgroundColor: Colors.white),
                                    height: 20,
                                    width: 20)
                                : const Text('Login'),
                            onPressed: () async {
                              print(_userNameInput.text);
                              print(_passWordInput.text);
                              SessionPreferences()
                                  .getCompanySettings()
                                  .then((settings) {
                                if (settings.baseUrl == null) {
                                  Fluttertoast.showToast(
                                      msg: 'Set Company URL');
                                }
                              });
                              if (_loginFormKey.currentState!.validate()) {
                                setState(() {
                                  _loggingIn = true;
                                });
                                String username = _userNameInput.text.trim();
                                String password = _passWordInput.text.trim();
                                var bytes = utf8.encode(password);
                                String encodedPassword = base64.encode(bytes);

                                HttpClient httpClient = HttpClient();
                                httpClient.badCertificateCallback =
                                    (X509Certificate cert, String host,
                                            int port) =>
                                        true;
                                URLQueryParams urqp = URLQueryParams();
                                urqp.append('username', username);
                                urqp.append('password', encodedPassword);
                                String url = await Config.getBaseUrl();
                                Uri uri = Uri.parse(url +
                                    'mobileuser/login?' +
                                    urqp.toString());
                                print(uri);
                                HttpClientRequest request =
                                    await httpClient.getUrl(uri);
                                late HttpClientResponse response;
                                String result;
                                try {
                                  response = await request.close();
                                } on SocketException {
                                  Fluttertoast.showToast(
                                      msg:
                                          'You may be offline. Check your connection');
                                } on HandshakeException {
                                  Fluttertoast.showToast(
                                      msg: 'Handshake exception occured');
                                }
                                if (response != null) {
                                  setState(() {
                                    _loggingIn = false;
                                  });
                                  int statusCode = response.statusCode;

                                  if (statusCode == 200) {
                                    response
                                        .transform(utf8.decoder)
                                        .listen((data) {
                                      print("Login response:::" +
                                          response.toString());
                                      print(data);
                                      User user =
                                          User.fromJson(json.decode(data));
                                      if (user.id! > 0) {
                                        SessionPreferences()
                                            .setLoggedInUser(user);
                                        SessionPreferences()
                                            .setLoggedInStatus(true);

                                        setState(() {
                                          _loggedIn = true;
                                          _loggedInUser = user;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TabsPage(selectedIndex: 0)),
                                          );
                                        });
                                        Fluttertoast.showToast(
                                            msg: 'Welcome $username');
                                      } else if (user.id! < 0) {
                                        Fluttertoast.showToast(
                                            msg:
                                                'The password you entered is incorrect',
                                            toastLength: Toast.LENGTH_LONG);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Please check your username and password',
                                            toastLength: Toast.LENGTH_LONG);
                                      }
                                    });
                                  } else if (statusCode == 500) {
                                    // Fluttertoast.showToast(
                                    //     msg: 'Error $statusCode Occured');
                                    showDialog(
                                        context: _context,
                                        builder: (BuildContext bc) {
                                          return CupertinoAlertDialog(
                                            title:
                                                const Text('Connection Error'),
                                            content: const Text(
                                                'There is a connection issue with the server! Please try again later'),
                                            actions: <Widget>[
                                              FlatButton(
                                                  onPressed: () {
                                                    Navigator.pop(bc);
                                                  },
                                                  child: const Text('Ok'))
                                            ],
                                          );
                                        });
                                  }
                                } else {
                                  setState(() {
                                    _loggingIn = false;
                                  });
                                  Fluttertoast.showToast(
                                      msg: 'No response from the server');
                                }
                              }
                            },
                          )),
                      Row(
                        children: <Widget>[
                          const Text('Change company URL?'),
                          FlatButton(
                            textColor: Colors.red,
                            child: const Text(
                              'Company URL',
                              style: TextStyle(fontSize: 20),
                            ),
                            onPressed: () async {
                              setState(() {
                                _companySettingsDone = false;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => ChooseCompany(imgName)),
                                );
                              });
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      )
                    ],
                  )),
            ));
      } else {
        return ChooseCompany((imgName) {
          setState(() {
            _imgFromSettings = imgName;
            _companySettingsDone = true;
          });
        });
      }
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text('Load Company Settings')),
        body: const Center(
          child: const Text('Loading your settings. Please wait ... '),
        ),
      );
    }
  }

  void imgName(String p1) {
    _imgFromSettings = imgName as String;
  }
}
