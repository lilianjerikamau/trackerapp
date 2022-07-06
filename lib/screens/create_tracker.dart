import 'dart:convert';
import 'dart:developer';

import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
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
    dateinput.text = ""; //set the initial value of text field
    super.initState();
  }

  late String _selectedValue = 'Individual';
  late int? loansNumber = null;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey4 = GlobalKey<FormState>();
  final _formKey5 = GlobalKey<FormState>();
  final _formKey6 = GlobalKey<FormState>();
  final _formKey7 = GlobalKey<FormState>();
  final _formKey8 = GlobalKey<FormState>();
  final _formKey9 = GlobalKey<FormState>();
  final _formKey10 = GlobalKey<FormState>();
  final _formKey11 = GlobalKey<FormState>();
  final _formKey12 = GlobalKey<FormState>();
  final _formKey13 = GlobalKey<FormState>();
  final _formKey14 = GlobalKey<FormState>();
  final _formKey15 = GlobalKey<FormState>();
  final _formKey16 = GlobalKey<FormState>();
  bool isLoading = false;
  bool isOtherEnabled = false;
  bool isOtherEnabled2 = false;
  bool isOtherEnabled3 = false;
  int hasBankAccount = 1;
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

  late int totalLoan;
  late String frequencyOfTransactionText;
  late String operationTime;

  late String paymentPeriodInMonths, loanTaker;
  List<String> selectedCategory = [];
  List<String> selectedCategory2 = [];
  List<String> selectedCategory3 = [];
  List<String> selectedCategory4 = [];
  List<String> selectedCategory5 = [];
  List<String> selectedCategory6 = [];
  List<String> selectedCategory7 = [];
  List<Widget> widgets = [];
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
        floatingActionButton: FloatingActionButton.extended(
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("Make sure all required fields are filled"),
                      duration: Duration(seconds: 3),
                    ));
                  }
                  break;
                case 1:
                  form = _formKey2.currentState;
                  if (form.validate()) {
                    form.save();
                    currentForm = 2;
                    percentageComplete = 50;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("Make sure all required fields are filled"),
                      duration: Duration(seconds: 3),
                    ));
                  }
                  break;
                case 2:
                  form = _formKey3.currentState;

                  if (form.validate()) {
                    form.save();
                    currentForm = 3;
                    percentageComplete = 75;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("Make sure all required fields are filled"),
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("Make sure all required fields are filled"),
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
          icon: Icon(
              currentForm == 4 ? Icons.upload_rounded : Icons.arrow_forward),
          label: Text(currentForm == 4 ? "finish" : "next"),
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
                                style: const TextStyle(
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
                        child: Container(
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
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
                                  SizedBox(
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText:
                                            "Enter client's phone number"),
                                  ),
                                  SizedBox(
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: const InputDecoration(
                                        hintText: "Enter client's email"),
                                  ),
                                  SizedBox(
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
                                    hint: Text(
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
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
                                  SizedBox(
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
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText:
                                            "Enter supplier's phone number"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter commission amount"),
                                  ),
                                ],
                              ),
                            ))
                      ])),
                  Form(
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 30, bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Registration",
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
                                        hintText:
                                            "Enter Vehicle Registration No"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Model"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Type"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Chassis No"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Engine No"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Color"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Vehicle Location"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Region"),
                                  ),
                                  SizedBox(
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
                                    hint: Text(
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
                                  SizedBox(
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
                                    hint: Text(
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
                                  SizedBox(
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
                                    hint: Text(
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
                                  SizedBox(
                                    height: 10,
                                  ),
                                  DropdownButtonFormField(
                                    // value: _selectedValue,
                                    hint: Text(
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
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
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
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter IMEI Service"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Backup1 IMEI Number"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Backup2 IMEI Number"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Device No"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Backup1 Device No"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Backup2 Device No"),
                                  ),
                                  SizedBox(
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
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Expiry(Months)"),
                                  ),
                                  SizedBox(
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
                                  TextFormField(
                                    validator: (value) => value!.isEmpty
                                        ? "This field is required"
                                        : null,
                                    onSaved: (value) => {},
                                    keyboardType: TextInputType.phone,
                                    decoration: const InputDecoration(
                                        hintText: "Enter Remarks"),
                                  ),
                                  TextField(
                                    controller:
                                        dateinput, //editing controller of this TextField
                                    decoration: const InputDecoration(
                                        icon: Icon(
                                          Icons.calendar_today,
                                          color: Colors.red,
                                        ), //icon of text field
                                        labelText:
                                            "Enter Date" //label text of field
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
                    key: _formKey16,
                    child: Column(children: <Widget>[
                      Card(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.redAccent, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: EdgeInsets.only(
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
                                SizedBox(
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
                                    SizedBox(
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
                                    SizedBox(
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
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.red),
                                SizedBox(
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.redAccent, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: EdgeInsets.only(
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
                                SizedBox(
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
                                    SizedBox(
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
                                    SizedBox(
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
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.red),
                                SizedBox(
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          elevation: 0.9,
                          shape: RoundedRectangleBorder(
                              side:
                                  BorderSide(color: Colors.redAccent, width: 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Padding(
                            padding: EdgeInsets.only(
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
                                SizedBox(
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
                                    SizedBox(
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
                                    SizedBox(
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
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                Divider(color: Colors.red),
                                SizedBox(
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                    Flexible(
                                      child: CheckboxListTile(
                                        title: Text('OK'),
                                        value: selectedCategory2.contains("OK"),
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            if (value!) {
                                              selectedCategory2.add("OK");
                                            } else {
                                              selectedCategory2.remove("OK");
                                            }
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
    // TODO: implement build
    throw UnimplementedError();
  }
}
