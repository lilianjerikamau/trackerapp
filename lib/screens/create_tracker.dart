import 'dart:convert';
import 'dart:developer';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:trackerapp/widgets/validators.dart';
// import 'package:seedfund/constants/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class CreateTracker extends StatefulWidget {
  _CreateTracker createState() => _CreateTracker();
}

const TWO_PI = 3.14 * .6;
List<String> selectedCategory = [];

List<String> listOfValue = ['Individual', 'Bank', 'Others'];

class _CreateTracker extends State<CreateTracker> {
  TextEditingController dateinput = TextEditingController();
  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    String YYYY_MM_DD = dateTime.toIso8601String().split('T').first;
    dateinput.text = YYYY_MM_DD; //set the initial value of text field
    super.initState();
  }

  late String _selectedValue = 'Individual';
  late int? loansNumber = null;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  final _formKey16 = GlobalKey<FormState>();
  bool isLoading = false;

  bool isOther5 = false;
  bool isOther6 = false;

  int currentForm = 0;

  int percentageComplete = 0;

  bool selectedCategory = true;
  bool selectedCategory2 = true;
  bool selectedCategory3 = true;
  bool selectedCategory4 = true;
  bool selectedCategory5 = true;
  bool selectedCategory6 = true;
  bool selectedCategory7 = true;
  bool selectedCategory8 = true;
  bool selectedCategory9 = true;
  bool selectedCategory10 = true;
  bool selectedCategory11 = true;
  bool selectedCategory12 = true;
  bool selectedCategory13 = true;
  bool selectedCategory14 = true;
  bool selectedCategory15 = true;
  bool selectedCategory16 = true;
  bool selectedCategory17 = true;
  bool selectedCategory18 = true;
  bool selectedCategory19 = true;
  bool selectedCategory20 = true;
  bool selectedCategory21 = true;
  bool selectedCategory22 = true;
  bool selectedCategory23 = true;
  bool selectedCategory24 = true;
  bool selectedCategory25 = true;
  bool selectedCategory26 = true;
  bool selectedCategory27 = true;
  bool selectedCategory28 = true;
  bool selectedCategory29 = true;
  bool selectedCategory30 = true;
  bool selectedCategory31 = true;
  bool selectedCategory32 = true;
  bool selectedCategory33 = true;
  bool selectedCategory34 = true;

  // Future<Map<String, dynamic>> sheiqdata(Map<String, dynamic> body) async {
  //   final prefs = await SharedPreferences.getInstance();

  //   String token = prefs.getString("token");
  //   String user = prefs.getInt("user").toString();
  //   print("post call started with ${body.toString()}");
  //   Map<String, dynamic> fullBody = body;
  //   fullBody["userid"] = user;
  //   final http.Response response = await http.post(
  //     AppUrl.sheIq,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(fullBody),
  //   );

  //   print(response.body);

  //   return {
  //     "status": response.statusCode,
  //     "body": response.statusCode == 200 ? response.body : "An error occured"
  //   };

//     if (response.statusCode == 201) {
//       final jsonData = json.decode(response.body);
//       var prof = jsonData["res"];
// //      return Album.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to create album.');
//     }
  // }

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton.extended(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                onPressed: () {
                  print("the current form is $currentForm");
                  setState(() {
                    var form;
                    switch (currentForm) {
                      case 0:
                        form = _formKey.currentState;
                        if (currentForm == 0) {
                          currentForm = 0;
                          percentageComplete = 25;
                        } else {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(const SnackBar(
                          //   behavior: SnackBarBehavior.floating,
                          //   content: Text(
                          //       "Make sure all required fields are filled"),
                          //   duration: Duration(seconds: 3),
                          // ));
                        }
                        break;
                      case 1:
                        form = _formKey2.currentState;
                        if (currentForm == 1) {
                          currentForm = 0;
                          percentageComplete = 50;
                        } else {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(const SnackBar(
                          //   behavior: SnackBarBehavior.floating,
                          //   content: Text(
                          //       "Make sure all required fields are filled"),
                          //   duration: Duration(seconds: 3),
                          // ));
                        }
                        break;
                      case 2:
                        form = _formKey3.currentState;

                        if (currentForm == 2) {
                          currentForm = 1;
                          percentageComplete = 75;
                        } else {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(const SnackBar(
                          //   behavior: SnackBarBehavior.floating,
                          //   content: Text(
                          //       "Make sure all required fields are filled"),
                          //   duration: Duration(seconds: 3),
                          // ));
                        }
                        break;
                      case 3:
                        form = _formKey16.currentState;

                        if (currentForm == 3) {
                          currentForm = 2;
                          percentageComplete = 100;
                        } else {
                          // ScaffoldMessenger.of(context)
                          //     .showSnackBar(const SnackBar(
                          //   behavior: SnackBarBehavior.floating,
                          //   content: Text(
                          //       "Make sure all required fields are filled"),
                          //   duration: Duration(seconds: 3),
                          // ));
                        }
                        break;
                    }
                  });
                },
                icon: Icon(
                  currentForm == 0 || currentForm == 4
                      ? Icons.error
                      : Icons.arrow_back,
                  color: Colors.redAccent,
                ),
                label: Text(
                    currentForm == 0 || currentForm == 4 ? "Invalid" : "Prev"),
                heroTag: null,
              ),
            ),
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
                        form = _formKey.currentState;
                        if (form.validate()) {
                          form.save();

                          currentForm = 1;
                          percentageComplete = 25;
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                "Make sure all required fields are filled"),
                            duration: Duration(seconds: 3),
                          ));
                        }
                        break;
                      case 1:
                        form = _formKey2.currentState;
                        if (form.validate()) {
                          form.save();
                          currentForm = 2;
                          percentageComplete = 75;
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                "Make sure all required fields are filled"),
                            duration: Duration(seconds: 3),
                          ));
                        }
                        break;
                      case 2:
                        form = _formKey3.currentState;

                        if (form.validate()) {
                          form.save();
                          currentForm = 3;
                          percentageComplete = 50;
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                "Make sure all required fields are filled"),
                            duration: Duration(seconds: 3),
                          ));
                        }
                        break;
                      case 3:
                        form = _formKey16.currentState;

                        if (form.validate()) {
                          form.save();
                          currentForm = 4;
                          percentageComplete = 100;
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                                "Make sure all required fields are filled"),
                            duration: Duration(seconds: 3),
                          ));
                        }
                        break;
                      // case 16:
                      //   var uploadData = {
                      //     "loanNumber": loansNumber,
                      //     "loanPurpose": selectedCategory,
                      //     "whereTaken": selectedCategory2,
                      //     "longAgoTaken": paymentPeriodInMonths,
                      //     "whoTookLoan": loanTaker,
                      //     "bankAccount": hasBankAccount,
                      //     "card": hasCard,
                      //     "insurance": hasInsurance,
                      //     "totalLoan": totalLoan,
                      //     "noLoanQuery": selectedCategory3,
                      //     "business": hasCard,
                      //     "type": selectedCategory4,
                      //     "operationTime": operationTime,
                      //     "industry": selectedCategory5,
                      //     "businessTypeOfLoan": selectedCategory6,
                      //     "collateralType": selectedCategory7,
                      //   };

                      //   sheiqdata(uploadData).then((value) => {
                      //         if (value["status"] == 200)
                      //           {Navigator.pop(context)}
                      //         else
                      //           {
                      //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //               behavior: SnackBarBehavior.floating,
                      //               content: Text(
                      //                   "An error occurred while doing the operation,make sure you have internet access"),
                      //               duration: Duration(seconds: 3),
                      //             ))
                      //           }
                      //       });

                    }
                  });
                },
                icon: Icon(currentForm == 4
                    ? Icons.upload_rounded
                    : Icons.arrow_forward),
                label: Text(currentForm == 4 ? "finish" : "Next"),
                heroTag: null,
              ),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
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
                        height: containerHeight,
                      ),
                    ),
                    Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        left: 0.0,
                        top: -100.0,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Create Tracker',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                '$percentageComplete% complete',
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                      bottom: -40.0,
                      right: 0.0,
                      left: 0.0,
                      height: 140.0,
                      child: AspectRatio(
                        aspectRatio: 300 / 145,
                        child: SizedBox(
                          width: size,
                          height: size,
                          child: Stack(
                            children: [
                              Center(
                                child: ShaderMask(
                                  shaderCallback: (rect) {
                                    return const SweepGradient(
                                        startAngle: 0.0,
                                        endAngle: TWO_PI,
                                        stops: [0.7, 0.7],
                                        // 0.0 , 0.5 , 0.5 , 1.0
                                        center: Alignment.center,
                                        colors: [
                                          Colors.red,
                                          Colors.transparent
                                        ]).createShader(rect);
                                  },
                                  child: Container(
                                    width: size,
                                    height: size,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Center(
                                      child: Image.asset(
                                    'images/logo.png',
                                    width: 100,
                                    height: 100,
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                [
                  Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Client Information",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
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
                                        "Client Name",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        hintText: "Enter client's name"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Phone Number",
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
                                    validator: phoneValidator,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText:
                                            "Enter client's phone number"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Email",
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
                                    validator: emailValidator,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        hintText: "Enter client's email"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Account Type",
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
                                  DropdownButtonFormField(
                                    // value: _selectedValue,
                                    hint: const Text(
                                      "Enter Client's Account Type",
                                    ),
                                    isExpanded: true,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    onSaved: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    validator: (String? value) {
                                      if (!value!.isEmpty) {
                                        return null;
                                      } else {
                                        return "can't be empty";
                                      }
                                    },
                                    items: listOfValue.map((String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(
                                          val,
                                        ),
                                      );
                                    }).toList(),
                                  )
                                ],
                              ),
                            ))
                      ])),
                  Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey2,
                      child: Column(children: <Widget>[
                        Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Contact Person",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
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
                                        "Supplier Name",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.name,
                                    decoration: const InputDecoration(
                                        hintText: "Enter supplier's name"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Phone Number",
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
                                    validator: phoneValidator,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText:
                                            "Enter supplier's phone number"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Commission",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter commission amount"),
                                  ),
                                ],
                              ),
                            ))
                      ])),
                  Form(
                      autovalidateMode: AutovalidateMode.always,
                      key: _formKey3,
                      child: Column(children: <Widget>[
                        Card(
                            margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            elevation: 0,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tracker Installation Details",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
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
                                        "Registration No",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText:
                                            "Enter Vehicle Registration No"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Model",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Model"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Vehicle Type",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Type"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Chassis No",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Chassis No"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Engine No",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Engine No"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Color",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Color"),
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Location"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Region",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Region"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Installer",
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
                                  DropdownButtonFormField(
                                    // value: _selectedValue,
                                    hint: const Text(
                                      "Installer",
                                    ),
                                    isExpanded: true,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    onSaved: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: listOfValue.map((String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(
                                          val,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Sales Person",
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
                                  DropdownButtonFormField(
                                    // value: _selectedValue,
                                    hint: const Text(
                                      "Enter Sales Person",
                                    ),
                                    isExpanded: true,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    onSaved: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: listOfValue.map((String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(
                                          val,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Installation Branch",
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
                                  DropdownButtonFormField(
                                    // value: _selectedValue,
                                    hint: const Text(
                                      "Enter Installation Branch",
                                    ),
                                    isExpanded: true,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    onSaved: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: listOfValue.map((String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(
                                          val,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DropdownButtonFormField(
                                    // value: _selectedValue,
                                    hint: const Text(
                                      "Tracker Type",
                                    ),
                                    isExpanded: true,
                                    onChanged: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    onSaved: (String? value) {
                                      setState(() {
                                        _selectedValue = value!;
                                      });
                                    },
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return "can't be empty";
                                      } else {
                                        return null;
                                      }
                                    },
                                    items: listOfValue.map((String val) {
                                      return DropdownMenuItem(
                                        value: val,
                                        child: Text(
                                          val,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Tracker Location",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Tracker Location"),
                                  ),
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    title: Text(
                                      'Install Fuel Sensor',
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
                                  CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.trailing,
                                    title: Text(
                                      'Asset Status',
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "IMEI Service",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter IMEI Service"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Backup1 IMEI Number",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Backup1 IMEI Number"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Backup2 IMEI Number",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Backup2 IMEI Number"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Device No",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Device No"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Backup1 Device No",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Backup1 Device No"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Backup2 Device No",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Backup2 Device No"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Expiry(Months)",
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Expiry(Months)"),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                        "*",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(color: Colors.red),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Remarks"),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextField(
                                    controller:
                                        dateinput, //editing controller of this TextField

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
                                                  2020), //DateTime.now() - not to allow to choose before today.
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
                                          dateinput.text =
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
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formKey16,
                    child: Column(children: <Widget>[
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.redAccent, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Gauges",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Details",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "Before Installation",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "After Installation",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.red),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Fuel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory,
                                        value: selectedCategory,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory2,
                                        value: selectedCategory2,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory2 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Temperature:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory3,
                                        value: selectedCategory3,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory3 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory4,
                                        value: selectedCategory4,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory4 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Dashboard warning Light:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory5,
                                        value: selectedCategory5,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory5 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory6,
                                        value: selectedCategory6,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory6 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.redAccent, width: 1),
                              borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Lights",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Details",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "Before Installation",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "After Installation",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.red),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Headlights:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory7,
                                        value: selectedCategory7,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory7 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory8,
                                        value: selectedCategory8,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory8 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Breaklights:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory9,
                                        value: selectedCategory9,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory9 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory10,
                                        value: selectedCategory10,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory10 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Indicator Signal:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory12,
                                        value: selectedCategory12,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory12 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory13,
                                        value: selectedCategory13,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory13 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Hazard Lights:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory15,
                                        value: selectedCategory15,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory15 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory16,
                                        value: selectedCategory16,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory16 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Fog Lights:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory17,
                                        value: selectedCategory17,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory17 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory18,
                                        value: selectedCategory18,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory18 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Reserve Lights:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory19,
                                        value: selectedCategory19,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory19 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory20,
                                        value: selectedCategory20,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory20 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                      Card(
                          margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: const RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.redAccent, width: 1),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 0, right: 0, top: 30, bottom: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Others",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Details",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "Before Installation",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: Text(
                                        "After Installation",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                const Divider(color: Colors.red),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Windscreen Wipers:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory21,
                                        value: selectedCategory21,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory21 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory22,
                                        value: selectedCategory22,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory22 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Fans and Defroster:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory23,
                                        value: selectedCategory23,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory23 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory24,
                                        value: selectedCategory24,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory24 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Brakes:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        selected: selectedCategory25,
                                        title: const Text('OK'),
                                        value: selectedCategory25,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory25 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory26,
                                        value: selectedCategory26,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory26 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Parking Brakes:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory27,
                                        value: selectedCategory27,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory27 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory28,
                                        value: selectedCategory28,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory28 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Mirrors:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory29,
                                        value: selectedCategory29,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory29 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory30,
                                        value: selectedCategory30,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory30 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Horn:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory31,
                                        value: selectedCategory31,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory31 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory32,
                                        value: selectedCategory32,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory32 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Exhaust System:",
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2!
                                            .copyWith(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory33,
                                        value: selectedCategory33,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory33 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: const Text('OK'),
                                        selected: selectedCategory34,
                                        value: selectedCategory34,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            selectedCategory34 = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ]),
                  ),
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
                                "Tracker Created Succesfully!",
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
}
