import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:trackerapp/models/financiermodels.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:trackerapp/models/technicianmodels.dart';
import 'package:trackerapp/models/trackermodels.dart';
import 'package:trackerapp/models/usermodels.dart';
import 'package:trackerapp/screens/home.dart';
import 'package:trackerapp/screens/search_screen.dart';
import 'package:trackerapp/widgets/validators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackerapp/utils/config.dart' as Config;
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:query_params/query_params.dart';

class MaintainJobCard extends StatefulWidget {
  _MaintainJobCard createState() => _MaintainJobCard();
}

const TWO_PI = 3.14 * .6;
List<String> selectedCategory = [];

List<String> listOfValue = ['Individual', 'Bank', 'Others'];

class _MaintainJobCard extends State<MaintainJobCard> {
  late User _loggedInUser;
  TextEditingController _dateinput = TextEditingController();
  TextEditingController _itemDescController = new TextEditingController();
  int? _userid;
  int? _custid;

  String? _trackerdocno;
  int? _trackerid;
  String? _custmobile;
  String? _financier;
  String? _vehreg;
  String? _imei;
  String? _model;
  String? _trackertype;
  String? _trackerlocation;
  String? _device;
  String? _customer;

  Customer? _selectedCustomer;
  bool? isExistingTracker;
  List<Tracker>? _trackers;
  List<Technician>? _technicians;
  List trackersJson = [];
  List techniciansJson = [];
  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
    _dateinput.text = formattedDate; //set the initial value of text field
    SessionPreferences().getLoggedInUser().then((user) {
      setState(() {
        _loggedInUser = user;
        _userid = user.id;
      });
    });
    _fetchOldTracker();
    _fetchTechnicians();
    _techId = null;
    isExistingTracker = false;
    super.initState();
  }

  bool _searchmode = false;
  late BuildContext _context;

  TextEditingController _searchController = new TextEditingController();

  final _location = TextEditingController();
  final _remarks = TextEditingController();
  final _installationdate = TextEditingController();

  bool _isEnable = false;

  late int? loansNumber = null;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey16 = GlobalKey<FormState>();
  String? _searchString;
  bool isLoading = false;
  var _selectedValue = null;
  var _selectedInstaller = null;
  bool isOther5 = false;
  bool isOther6 = false;
  bool isOther7 = false;
  late String otherValue6;
  late String otherValue7;

  int currentForm = 0;
  int frequencyOfTransaction = 0;
  int hasInsurance = 1;
  int hasCard = 1;
  int doYouOwnaBusiness = 1;
  int percentageComplete = 0;
  static late var _techId;
  static late var _techName;
  // String location = _location.text.trim();
  //   String installationdate = _installationdate.text;

  late String otherValue1;
  late String otherValue2;
  late String otherValue3;
  late String otherValue5;
  static final double containerHeight = 170.0;
  double clipHeight = containerHeight * 0.35;
  DiagonalPosition position = DiagonalPosition.BOTTOM_LEFT;
  final size = 200.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onPressed: () {
                  print("the current form is $currentForm");
                  setState(() {
                    var form;
                    switch (currentForm) {
                      case 0:
                        form = _formKey16.currentState;
                        if (form.validate()) {
                          form.save();

                          percentageComplete = 100;
                          _submit();
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                "Make sure all required fields are filled"),
                            duration: Duration(seconds: 3),
                          ));
                        }
                    }
                  });
                },
                icon: Icon(currentForm == 1
                    ? Icons.upload_rounded
                    : Icons.arrow_forward),
                label: Text(currentForm == 1 ? "Submit" : "Submit"),
              ),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: Builder(
            builder: (BuildContext context) {
              return RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            top: true,
            child: Column(
              children: <Widget>[
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    isLoading
                        ? const LinearProgressIndicator()
                        : const SizedBox(),
                    Diagonal(
                      position: position,
                      clipHeight: clipHeight,
                      child: Container(
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'Create Meintenance Job Card',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                [
                  Form(
                      key: _formKey16,
                      child: Column(children: <Widget>[
                        Card(
                            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 0, bottom: 0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(),
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                ],
                              ),
                            )),
                        Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Old Tracker",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "*",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.red),
                                      )
                                    ],
                                  ),
                                  SearchableDropdown(
                                    hint: const Text(
                                      "Select Tracker",
                                    ),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      _selectedValue = value;

                                      _trackerdocno = value != null
                                          ? value['trackerdocno']
                                          : null;
                                      _trackerid = value != null
                                          ? value['trackerid']
                                          : null;
                                      _financier = value != null
                                          ? value['financier']
                                          : null;
                                      _custmobile = value != null
                                          ? value['custmobile']
                                          : null;
                                      _vehreg = value != null
                                          ? value['vehreg']
                                          : null;
                                      _imei =
                                          value != null ? value['imei'] : null;
                                      _model =
                                          value != null ? value['model'] : null;
                                      _trackertype = value != null
                                          ? value['trackertype']
                                          : null;
                                      _trackerlocation = value != null
                                          ? value['trackerlocation']
                                          : null;
                                      _device = value != null
                                          ? value['device']
                                          : null;
                                      _customer = value != null
                                          ? value['customer']
                                          : null;

                                      setState(() {
                                        // _selectedValue = value!;
                                      });
                                      print(_selectedValue);
                                    },

                                    // isCaseSensitiveSearch: true,
                                    searchHint: const Text(
                                      'Select Tracker',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    items: trackersJson.map((val) {
                                      return DropdownMenuItem(
                                        child: getListTile(val),
                                        value: val,
                                      );
                                    }).toList(),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Technician",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "*",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.red),
                                      )
                                    ],
                                  ),
                                  SearchableDropdown(
                                    // value: _selectedValue,
                                    hint: const Text(
                                      "Preferred Technician",
                                    ),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      (value) => value == null
                                          ? 'field required'
                                          : null;
                                      _selectedInstaller = value;
                                      _techId =
                                          value != null ? value['empid'] : null;
                                      _techName = value != null
                                          ? value['empname']
                                          : null;
                                      setState(() {
                                        // _selectedValue = value!;
                                      });
                                      print(_selectedInstaller);
                                      print(_techName);
                                      print(_techId);
                                      SessionPreferences()
                                          .getSelectedTechnician()
                                          .then((customer) {
                                        setState(() {
                                          _selectedInstaller = value;
                                          _techId = value['empid'];
                                          _techName = value['empname'];
                                        });
                                      });
                                    },

                                    value: _selectedInstaller,

                                    // isCaseSensitiveSearch: true,
                                    searchHint: new Text(
                                      'Select Technician ',
                                      style: new TextStyle(fontSize: 20),
                                    ),
                                    items: techniciansJson.map((val) {
                                      return DropdownMenuItem(
                                        child: Text(val['empname']),
                                        value: val,
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Location",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "*",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.red),
                                      )
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _location,
                                    validator: (value) => _customer == null
                                        ? 'Select Old Tracker'
                                        : value!.isEmpty
                                            ? "This field is required "
                                            : _techId == null
                                                ? 'Select Technician'
                                                : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Location"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    title: Text(
                                      'Add Tracker',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    value: isOther6,
                                    activeColor: Colors.red,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isOther6 = value!;
                                      });
                                    },
                                  ),
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    title: Text(
                                      'Remove Tracker',
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(),
                                    ),
                                    value: isOther5,
                                    activeColor: Colors.red,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isOther5 = value!;
                                      });
                                    },
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Remarks",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.red),
                                      )
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _remarks,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Remarks"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Timeline",
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                      Text(
                                        "",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.red),
                                      )
                                    ],
                                  ),
                                  TextField(
                                    controller:
                                        _dateinput, //editing controller of this TextField
                                    decoration: const InputDecoration(
                                      icon: Icon(
                                        Icons.calendar_today,
                                        color: Colors.red,
                                      ), //icon of text field
                                    ),
                                    readOnly:
                                        true, //set it true, so that user will not able to edit text
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(
                                                  2000), //DateTime.now() - not to allow to choose before today.
                                              lastDate: DateTime(2101));

                                      if (pickedDate != null) {
                                        print(
                                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        print(
                                            formattedDate); //formatted date output using intl package =>  2021-03-16
                                        //you can implement different kind of Date Format here according to your requirement

                                        setState(() {
                                          _dateinput.text =
                                              formattedDate; //set output date to TextField value.
                                        });
                                      } else {
                                        print("Date is not selected");
                                      }
                                    },
                                  )
                                ],
                              ),
                            ))
                      ])),
                  Column(children: <Widget>[
                    Card(
                        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 30, bottom: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        )),
                  ])
                ][currentForm]
              ],
            ),
          ),
        ));
  }

  Widget getListTile(val) {
    return ListTile(
      leading: Text(val['vehReg'] ?? ''),
      title: Text(val['customer'] ?? ''),
      trailing: Text(val['model'] ?? ''),
      subtitle: Text(val['custmobile'] ?? ''),
    );
  }

  _fetchOldTracker() async {
    String url = await Config.getBaseUrl();

    HttpClientResponse response = await Config.getRequestObject(
        url + 'trackerjobcard/trackers/?param=', Config.get);
    if (response != null) {
      print(response);
      response.transform(utf8.decoder).transform(LineSplitter()).listen((data) {
        var jsonResponse = json.decode(data);
        print(jsonResponse);
        setState(() {
          trackersJson = jsonResponse;
        });
        var list = jsonResponse as List;
        List<Tracker> result = list.map<Tracker>((json) {
          return Tracker.fromJson(json);
        }).toList();
        if (result.isNotEmpty) {
          // print(result);
          setState(() {
            result.sort((a, b) =>
                a.customer!.toLowerCase().compareTo(b.customer!.toLowerCase()));
            _trackers = result;
            print(_trackers);
          });
        } else {
          setState(() {
            // _message = 'You have not been assigned any customers';
          });
        }
      });
    } else {
      print('response is null ');
    }
  }

  _fetchTechnicians() async {
    String url = await Config.getBaseUrl();

    HttpClientResponse response = await Config.getRequestObject(
        url + 'trackerjobcard/technician/', Config.get);
    if (response != null) {
      print(response);
      response.transform(utf8.decoder).transform(LineSplitter()).listen((data) {
        var jsonResponse = json.decode(data);
        print(jsonResponse);
        setState(() {
          techniciansJson = jsonResponse;
        });
        var list = jsonResponse as List;
        List<Technician> result = list.map<Technician>((json) {
          return Technician.fromJson(json);
        }).toList();
        if (result.isNotEmpty) {
          // print(result);
          setState(() {
            result.sort((a, b) =>
                a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
            _technicians = result;
            print(_technicians);
          });
        } else {
          setState(() {
            // _message = 'You have not been assigned any customers';
          });
        }
      });
    } else {
      print('response is null ');
    }
  }

  _submit() async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text('Submit?'),
            content: Text('Are you sure you want to submit?'),
            actions: <Widget>[
              FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(ctx);
                  }),
              FlatButton(
                  onPressed: () async {
                    Navigator.pop(ctx);
                    String location = _location.text.trim();
                    String remarks = _remarks.text.trim();
                    String dateinput = _dateinput.text;
                    LinearProgressIndicator dial = LinearProgressIndicator();

                    String demoUrl = await Config.getBaseUrl();
                    Uri url = Uri.parse(demoUrl + 'trackerjobcard/');
                    print(url);

                    final response = await http.post(url,
                        headers: <String, String>{
                          'Content-Type': 'application/json',
                        },
                        body: jsonEncode(<String, dynamic>{
                          "jobcardtypeid": 1,
                          "trackerid": _trackerid,
                          "addition": isOther6,
                          "removed": isOther5,
                          "location": location,
                          "installationdate": dateinput.toString(),
                          "userid": _userid,
                          "technicianid": _techId,
                          "remarks": remarks == null ? "" : remarks,
                        }));

                    print(jsonEncode(<String, dynamic>{
                      "jobcardtypeid": 1,
                      "trackerid": _trackerid,
                      "addition": isOther6,
                      "removed": isOther5,
                      "location": location,
                      "installationdate": dateinput.toString(),
                      "userid": _userid,
                      "technicianid": _techId,
                      "remarks": remarks == null ? "" : remarks,
                    }));
                    if (response != null) {
                      int statusCode = response.statusCode;
                      if (statusCode == 200) {
                        return _showDialog(context);
                      } else {
                        print(
                            "Submit Status code::" + response.body.toString());
                        showAlertDialog(context, response.body);
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: 'There was no response from the server');
                    }
                  },
                  child: Text('Yes'))
            ],
          );
        });
  }
}

void showAlertDialog(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext bc) {
        return CupertinoAlertDialog(
          title: Text('Error!'),
          content: Text('$message'),
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

void _showDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(
      "Success!",
      style: TextStyle(color: Colors.green),
    ),
    content: Text("You have successfully posted Job Card"),
    actions: [
      okButton,
    ],
  );
  //   context: context,
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
