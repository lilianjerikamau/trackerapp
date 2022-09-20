import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:trackerapp/models/usermodels.dart';
import 'package:trackerapp/utils/config.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:query_params/query_params.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class NewPass extends StatefulWidget {
  String status;
  NewPass(this.status, {Key? key}) : super(key: key);

  @override
  _NewPassState createState() => _NewPassState();
}

class _NewPassState extends State<NewPass> {
  late User _thisUser;
  late BuildContext _context;
  TextEditingController _oldPasswordController = new TextEditingController();
  TextEditingController _newPasswordController = new TextEditingController();
  TextEditingController _rptPasswordController = new TextEditingController();
  bool _showOldPass = true, _showNewPass = true, _showRptPass = true;
  GlobalKey<FormState> _formKey = new GlobalKey();

  @override
  void initState() {
    SessionPreferences().getLoggedInUser().then((user) {
      setState(() {
        _thisUser = user;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Container(
        color: Colors.white70,
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Visibility(
                    visible: widget.status == changePass,
                    child: const Text('Enter Your old password below')),
              ),
              Visibility(
                  visible: widget.status == changePass,
                  child: TextFormField(
                    controller: _oldPasswordController,
                    validator: widget.status == changePass
                        ? (value) {
                            if (value!.isEmpty) {
                              return 'Enter your old password';
                            } else {
                              return null;
                            }
                          }
                        : null,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: const BorderSide()),
                        labelText: 'Enter your old password',
                        suffixIcon: IconButton(
                            icon: _showOldPass
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _showOldPass ^= true;
                              });
                            })),
                    obscureText: _showOldPass,
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                    'Enter and repeat your new password in the inputs below',
                    style: TextStyle(fontSize: 18, color: Colors.teal)),
              ),
              TextFormField(
                controller: _newPasswordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter your new password';
                  }
                  return null;
                },
                obscureText: _showNewPass,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderSide: const BorderSide()),
                    labelText: 'Enter new Password',
                    suffixIcon: IconButton(
                        icon: _showNewPass
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _showNewPass ^= true;
                          });
                        })),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TextFormField(
                    controller: _rptPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Repeat your new password';
                      } else {
                        String newPass = _newPasswordController.text.trim();
                        if (newPass.isNotEmpty) {
                          if (newPass == value.trim()) {
                            return null;
                          } else {
                            return 'New password values must match';
                          }
                        } else {
                          return '';
                        }
                      }
                    },
                    obscureText: _showRptPass,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                            borderSide: const BorderSide()),
                        labelText: 'Repeat new Password',
                        suffixIcon: IconButton(
                            icon: _showRptPass
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _showRptPass ^= true;
                              });
                            })),
                  )),
              CupertinoButton(
                  color: Colors.blueGrey,
                  child: const Text('Change password'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ProgressDialog dial = new ProgressDialog(context);
                      String oldPass = _oldPasswordController.text.trim();
                      String newPassInput = _newPasswordController.text.trim();
                      String encodedNewPass =
                          base64.encode(utf8.encode(newPassInput));
                      int? userId = _thisUser.id;
                      if (widget.status == changePass) {
                        String encodedPass =
                            base64.encode(utf8.encode(oldPass));
                        dial.style(message: 'Verifying old password ... ');
                        dial.show();
                        URLQueryParams uqp = new URLQueryParams();
                        uqp.append('password', encodedPass);
                        String url = await getBaseUrl();
                        HttpClientResponse? rsp = await getRequestObject(
                            url +
                                'mobileuser/checkpass/$userId?' +
                                uqp.toString(),
                            get,
                            dialog: dial);
                        if (rsp != null) {
                          rsp.transform(utf8.decoder).listen((data) async {
                            var jsonResponse = json.decode(data);
                            bool correctPass = jsonResponse['correctPass'];
                            if (correctPass) {
                              dial.update(
                                  message: 'Updating new Password ... ');
                              // String jsonData = json.encode(User(id: userId,password: encodedNewPass));
                              HttpClientResponse? hcr = await getRequestObject(
                                  url + 'mobileuser/update', put,
                                  body: jsonEncode(<String, dynamic>{
                                    "id": userId,
                                    "password": encodedNewPass
                                  }),
                                  dialog: dial);
                              if (hcr != null) {
                                hcr.transform(utf8.decoder).listen((data) {
                                  var jsonResponse = json.decode(data);
                                  bool updated = jsonResponse['updated'];
                                  if (updated) {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Your password has been updated successfully');
                                    Navigator.pop(_context);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Update failed');
                                  }
                                });
                              }
                            } else {
                              dial.hide();
                              Fluttertoast.showToast(
                                  msg: 'Old password is wrong');
                            }
                          });
                        }
                      } else if (widget.status == forgotPass) {
                        dial.style(message: 'Updating password ... ');
                        dial.show();
                        String jsonData = json
                            .encode(User(id: userId, password: encodedNewPass));
                        String url = await getBaseUrl();
                        HttpClientResponse? res = await getRequestObject(
                            url + 'mobileuser/update', put,
                            body: jsonData, dialog: dial);
                        if (res != null) {
                          res.transform(utf8.decoder).listen((data) async {
                            var jsonResponse = json.decode(data);
                            bool updated = jsonResponse['updated'];
                            if (updated) {
                              Fluttertoast.showToast(
                                  msg: 'Your password has been updated');
                              SharedPreferences sharedpref =
                                  await SharedPreferences.getInstance();
                              sharedpref.setBool('updated', true).then((x) {
                                Navigator.pop(_context);
                              });
                            } else {
                              Fluttertoast.showToast(msg: 'Update failed');
                            }
                          });
                        }
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
