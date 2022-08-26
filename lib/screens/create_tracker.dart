import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:trackerapp/models/devicesmodels.dart';
import 'package:trackerapp/models/jobcardmodels.dart';
import 'package:trackerapp/models/technicianmodels.dart';
import 'package:trackerapp/models/usermodels.dart';
import 'package:trackerapp/screens/create_installation_job_card.dart';
import 'package:trackerapp/screens/home.dart';
import 'package:trackerapp/utils/config.dart' as Config;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:trackerapp/widgets/validators.dart';
// import 'package:seedfund/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreateTracker extends StatefulWidget {
  _CreateTracker createState() => _CreateTracker();
}

const TWO_PI = 3.14 * .6;

class _CreateTracker extends State<CreateTracker> {
  TextEditingController dateinput = TextEditingController();
  late BuildContext _context;
  TextEditingController _searchController = new TextEditingController();
  TextEditingController _itemDescController = new TextEditingController();
  List<String> selectedCategory = [];

  List<String> listOfValue = ['Individual', 'Bank', 'Others'];
  List<JobCard> _pendingInstJobCards = [];
  List<Device> _devicesJson = [];
  JobCard? jobCard;
  List<JobCard>? _jobcards;
  final _installationdate = TextEditingController();
  final _remarks = TextEditingController();

  TextEditingController _dateinput = TextEditingController();
  TextEditingController _chasisno = TextEditingController();
  TextEditingController _vehtype = TextEditingController();
  TextEditingController _vehcolor = TextEditingController();
  TextEditingController _engineno = TextEditingController();
  TextEditingController _region = TextEditingController();
  TextEditingController _trackerLocation = TextEditingController();
  List techniciansJson = [];
  List technicians = [];
  static late var _selectedInstaller = null;
  static late var _selectedJobCard = null;
  static late var _selectedValue = null;
  static late var _selectedImei = null;
  static late var _selectedImei1 = null;
  static late var _selectedImei2 = null;
  static late var _selectedDevice = null;
  static late var _selectedDevice1 = null;
  static late var _selectedDevice2 = null;
  static late var _custName;
  static late var _location;
  static late var _vehreg;
  static late var _vehmodel;

  static late var _custPhone;
  static late var _techName;
  static late var _techId;

  late int? loansNumber = null;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey16 = GlobalKey<FormState>();
  List pendinInstJobCardsJson = [];

  List devicesJson = [];
  bool isLoading = false;
  bool isOther5 = false;
  bool isOther6 = false;
  bool value1inspb1 = true;
  bool value1inspb2 = true;
  bool value1inspb3 = true;
  bool value1inspb4 = true;
  bool value1inspb5 = true;
  bool value1inspb6 = true;
  bool value1inspb7 = true;
  bool value1inspb8 = true;
  bool value1inspb9 = true;
  bool value1inspb10 = true;
  bool value1inspb11 = true;
  bool value1inspb12 = true;
  bool value1inspb13 = true;
  bool value1inspb14 = true;
  bool value1inspb15 = true;
  bool value1inspb16 = true;
  bool value1inspaf1 = true;
  bool value1inspaf2 = true;
  bool value1inspaf3 = true;
  bool value1inspaf4 = true;
  bool value1inspaf5 = true;
  bool value1inspaf6 = true;
  bool value1inspaf7 = true;
  bool value1inspaf8 = true;
  bool value1inspaf9 = true;
  bool value1inspaf10 = true;
  bool value1inspaf11 = true;
  bool value1inspaf12 = true;
  bool value1inspaf13 = true;
  bool value1inspaf14 = true;
  bool value1inspaf15 = true;
  bool value1inspaf16 = true;

  int currentForm = 0;
  int? currentFormState;
  int percentageComplete = 0;
  late User _loggedInUser;
  int? _userid;
  int? _hrid;
  String? _userName;
  String? _branchName;
  int? _costcenterid;
  String? _searchString;
  String? _dropdownDeviceError;
  String? _dropdownIMEIError;
  // String? _custPhone;
  String? _deviceSerialNo;
  String? _deviceDescription;
  int? _imeinoId;
  int? _imeinoId1;
  int? _imeinoId2;
  int? _devicenoId;
  int? _devicenoId1;
  int? _devicenoId2;
  int? _jobCardId;
  int? noJobCards;
  bool? isSelectedJobCard;
  late String otherValue1;
  late String otherValue2;
  late String otherValue3;
  late String otherValue5;
  static final double containerHeight = 170.0;
  double clipHeight = containerHeight * 0.35;
  DiagonalPosition position = DiagonalPosition.BOTTOM_LEFT;
  final size = 200.0;
  HashSet<String> set2 = new HashSet<String>();
  @override
  void initState() {
    isSelectedJobCard = false;
    _custName = null;
    _custPhone = null;
    _vehmodel = null;
    _vehreg = null;
    _location = null;
    DateTime dateTime = DateTime.now();
    String YYYY_MM_DD = dateTime.toIso8601String().split('T').first;
    dateinput.text = YYYY_MM_DD; //set the initial value of text field
    super.initState();
    SessionPreferences().getLoggedInUser().then((user) {
      setState(() {
        _loggedInUser = user;
        _userid = user.id;
        _hrid = user.hrid;
        _costcenterid = user.costcenter;
        _userName = user.username;
        _branchName = user.branchname;
      });
      print(_branchName);
      _fetchPendingInstallationJobCard();
      _fetchDeviceDetails();
      _fetchTechnicians();
    });
  }

  bool _searchmode = false;

  Widget build(BuildContext context) {
    return isSelectedJobCard == false
        ? Scaffold(
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            }
                            break;

                          case 1:
                            form = _formKey3.currentState;

                            if (currentForm == 1) {
                              currentForm = 0;
                              percentageComplete = 75;
                            }
                            break;
                          case 2:
                            form = _formKey16.currentState;

                            if (currentForm == 2) {
                              currentForm = 1;
                              percentageComplete = 100;
                            }
                            break;
                          case 3:
                            form = _formKey16.currentState;

                            if (currentForm == 3) {
                              currentForm = 2;
                              percentageComplete = 100;
                            }
                            break;
                        }
                      });
                    },
                    icon: Icon(
                      currentForm == 0 ? Icons.error : Icons.arrow_back,
                      color: Colors.redAccent,
                    ),
                    label: Text(currentForm == 0 ? "Invalid" : "Prev"),
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
                            form = _formKey3.currentState;
                            print(_selectedImei1);
                            print(_selectedDevice2);
                            print(_selectedImei != _selectedDevice);
                            if (form.validate()) {
                              form.save();
                              if (_selectedImei != null) {
                                if (_selectedDevice != null) {
                                  currentForm = 2;
                                  percentageComplete = 25;
                                } else {
                                  setState(() => _dropdownDeviceError =
                                      "This field is required");
                                }
                              } else {
                                setState(() => _dropdownIMEIError =
                                    "This field is required");
                              }
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
                            form = _formKey16.currentState;

                            if (form.validate()) {
                              form.save();
                              currentForm = 3;
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
                          case 3:
                            _submit();
                        }
                      });
                    },
                    icon: Icon(currentForm == 3
                        ? Icons.upload_rounded
                        : Icons.arrow_forward),
                    label: Text(currentForm == 3 ? "Submit" : "Next"),
                    heroTag: null,
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
                        Positioned(
                            child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text(
                                'Create Installation Tracker',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    [
                      Form(
                          key: _formKey,
                          child: Column(children: <Widget>[
                            Card(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 30, bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Client Information",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
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
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 30, bottom: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Attach Job Card",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(),
                                          ),
                                          GestureDetector(
                                            child: Icon(
                                              Icons.attach_file,
                                              color: Colors.red,
                                              size: 30.0,
                                            ),
                                            onTap: () {
                                              isSelectedJobCard = true;

                                              setState(() {});
                                            },
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
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
                                        readOnly: true,
                                        validator: (value) => value!.isEmpty
                                            ? "Attach Job Card"
                                            : null,
                                        initialValue: _custName,
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
                                            "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(color: Colors.red),
                                          )
                                        ],
                                      ),
                                      TextFormField(
                                        readOnly: true,
                                        initialValue: _custPhone,
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
                                        readOnly: true,
                                        validator: (value) => value!.isEmpty
                                            ? "This field is required"
                                            : null,
                                        initialValue: _vehreg,
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
                                        readOnly: true,
                                        initialValue: _vehmodel,
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
                                            "Location",
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
                                        initialValue: _location,
                                        readOnly: true,
                                        onSaved: (value) => {},
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Vehicle Location"),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ))
                          ])),
                      Form(
                          key: _formKey3,
                          child: Column(children: <Widget>[
                            Card(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 30, bottom: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tracker Installation Details",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
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
                                margin:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 30, bottom: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                        controller: _chasisno,
                                        validator: (value) => value!.isEmpty
                                            ? "This field is required"
                                            : null,
                                        onSaved: (value) => {},
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            hintText:
                                                "Enter Vehicle Chassis No"),
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
                                            "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(color: Colors.red),
                                          )
                                        ],
                                      ),
                                      TextFormField(
                                        controller: _engineno,
                                        onSaved: (value) => {},
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            hintText:
                                                "Enter Vehicle Engine No"),
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
                                        controller: _vehcolor,
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
                                        controller: _region,
                                        validator: (value) => value!.isEmpty
                                            ? "This field is required"
                                            : null,
                                        onSaved: (value) => {},
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Region"),
                                      ),

                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "Sales Person",
                                      //       overflow: TextOverflow.ellipsis,
                                      //       style: Theme.of(context)
                                      //           .textTheme
                                      //           .subtitle2!
                                      //           .copyWith(),
                                      //     ),
                                      //     Text(
                                      //       "*",
                                      //       style: Theme.of(context)
                                      //           .textTheme
                                      //           .subtitle2!
                                      //           .copyWith(color: Colors.red),
                                      //     )
                                      //   ],
                                      // ),
                                      // TextFormField(
                                      //   initialValue: _userName,
                                      //   readOnly: true,
                                      //   onSaved: (value) => {},
                                      //   keyboardType: TextInputType.text,
                                      //   decoration: const InputDecoration(
                                      //       hintText: "Sales Person"),
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     Text(
                                      //       "Installation Branch",
                                      //       overflow: TextOverflow.ellipsis,
                                      //       style: Theme.of(context)
                                      //           .textTheme
                                      //           .subtitle2!
                                      //           .copyWith(),
                                      //     ),
                                      //     Text(
                                      //       "*",
                                      //       style: Theme.of(context)
                                      //           .textTheme
                                      //           .subtitle2!
                                      //           .copyWith(color: Colors.red),
                                      //     )
                                      //   ],
                                      // ),
                                      // TextFormField(
                                      //   initialValue: _branchName,
                                      //   readOnly: true,
                                      //   onSaved: (value) => {},
                                      //   keyboardType: TextInputType.text,
                                      //   decoration: const InputDecoration(
                                      //       hintText: "Installation Branch"),
                                      // ),

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
                                        controller: _trackerLocation,
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
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "IMEI Device",
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
                                          "IMEI Device",
                                        ),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          setState(() {
                                            _checkDuplicates();
                                            _selectedImei = value != null
                                                ? value
                                                : 'Select IMEI Device';
                                            _imeinoId = value != null
                                                ? value['id']
                                                : null;
                                            _deviceSerialNo = value != null
                                                ? value['serialno']
                                                : null;
                                            _deviceDescription = value != null
                                                ? value['description']
                                                : null;
                                            _dropdownIMEIError = null;
                                            print(_selectedImei);
                                            print(_imeinoId);
                                            print(_deviceSerialNo);
                                            print(_deviceDescription);

                                            // set2.add(_selectedImei);
                                          });
                                        },

                                        // isCaseSensitiveSearch: true,
                                        searchHint: const Text(
                                          'Select IMEI Device ',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        items: devicesJson.map((val) {
                                          return DropdownMenuItem(
                                            child: getListTile(val),
                                            value: val,
                                          );
                                        }).toList(),
                                      ),
                                      _dropdownIMEIError == null
                                          ? SizedBox.shrink()
                                          : Text(
                                              _dropdownIMEIError ?? "",
                                              style:
                                                  TextStyle(color: Colors.red),
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
                                            "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(color: Colors.red),
                                          )
                                        ],
                                      ),
                                      SearchableDropdown(
                                        hint: const Text(
                                          "Backup1 IMEI Number",
                                        ),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          _checkDuplicates();
                                          _selectedImei1 = value;
                                          _imeinoId1 = value != null
                                              ? value['id']
                                              : null;
                                          _deviceSerialNo = value != null
                                              ? value['serialno']
                                              : null;
                                          _deviceDescription = value != null
                                              ? value['description']
                                              : null;

                                          print(_selectedImei);
                                          print(_imeinoId);
                                          print(_deviceSerialNo);
                                          print(_deviceDescription);
                                          // set2.add(_selectedImei1);
                                        },

                                        // isCaseSensitiveSearch: true,
                                        searchHint: const Text(
                                          'Select Backup1 IMEI Number',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        items: devicesJson.map((val) {
                                          return DropdownMenuItem(
                                            child: getListTile(val),
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
                                            "Backup2 IMEI Number",
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
                                      SearchableDropdown(
                                        hint: const Text(
                                          "Select Backup2 IMEI Number",
                                        ),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          _checkDuplicates();

                                          _selectedImei2 = value;
                                          _imeinoId2 = value != null
                                              ? value['id']
                                              : null;
                                          _deviceSerialNo = value != null
                                              ? value['serialno']
                                              : null;
                                          _deviceDescription = value != null
                                              ? value['description']
                                              : null;
                                          // set2.add(_selectedImei2);
                                          print(_selectedImei);
                                          print(_imeinoId);
                                          print(_deviceSerialNo);
                                          print(_deviceDescription);
                                        },

                                        // isCaseSensitiveSearch: true,
                                        searchHint: const Text(
                                          'Backup2 IMEI Number',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        items: devicesJson.map((val) {
                                          return DropdownMenuItem(
                                            child: getListTile(val),
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
                                      SearchableDropdown(
                                        hint: const Text(
                                          "Device No",
                                        ),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          setState(() {
                                            _checkDuplicates();

                                            _selectedDevice = value;
                                            _devicenoId = value != null
                                                ? value['id']
                                                : null;
                                            _deviceSerialNo = value != null
                                                ? value['serialno']
                                                : null;
                                            _deviceDescription = value != null
                                                ? value['description']
                                                : null;
                                            // set2.add(_selectedDevice);
                                            // print(_selectedImei);
                                            // print(_imeinoId);
                                            // print(_deviceSerialNo);
                                            // print(_deviceDescription);
                                            _dropdownDeviceError = null;
                                          });
                                        },

                                        // isCaseSensitiveSearch: true,
                                        searchHint: const Text(
                                          'Device No',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        items: devicesJson.map((val) {
                                          return DropdownMenuItem(
                                            child: getListTile(val),
                                            value: val,
                                          );
                                        }).toList(),
                                      ),
                                      _dropdownDeviceError == null
                                          ? SizedBox.shrink()
                                          : Text(
                                              _dropdownDeviceError ?? "",
                                              style:
                                                  TextStyle(color: Colors.red),
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
                                            "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(color: Colors.red),
                                          )
                                        ],
                                      ),
                                      SearchableDropdown(
                                        hint: const Text(
                                          "Backup1 Device No",
                                        ),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          _checkDuplicates();
                                          (value) => value == null
                                              ? 'field required'
                                              : null;
                                          _selectedDevice1 = value;
                                          _devicenoId1 = value != null
                                              ? value['id']
                                              : null;
                                          _deviceSerialNo = value != null
                                              ? value['serialno']
                                              : null;
                                          _deviceDescription = value != null
                                              ? value['description']
                                              : null;
                                          // set2.add(_selectedDevice1);
                                        },

                                        // isCaseSensitiveSearch: true,
                                        searchHint: const Text(
                                          'Select Backup1 Device No',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        items: devicesJson.map((val) {
                                          return DropdownMenuItem(
                                            child: getListTile(val),
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
                                            "Backup2 Device No",
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
                                      SearchableDropdown(
                                        hint: const Text(
                                          "Backup2 Device No",
                                        ),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          _checkDuplicates();
                                          (value) => value == null
                                              ? 'field required'
                                              : null;
                                          _selectedDevice2 = value;
                                          _devicenoId2 = value != null
                                              ? value['id']
                                              : null;
                                          _deviceSerialNo = value != null
                                              ? value['serialno']
                                              : null;
                                          _deviceDescription = value != null
                                              ? value['description']
                                              : null;

                                          // print(_selectedImei);
                                          // print(_imeinoId);
                                          // print(_deviceSerialNo);
                                          // print(_deviceDescription);
                                          // set2.add(_selectedDevice2);
                                        },

                                        // isCaseSensitiveSearch: true,
                                        searchHint: const Text(
                                          'Select Backup2 Device No',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        items: devicesJson.map((val) {
                                          return DropdownMenuItem(
                                            child: getListTile(val),
                                            value: val,
                                          );
                                        }).toList(),
                                      ),
                                      const SizedBox(
                                        height: 10,
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
                                        onSaved: (value) => {},
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Remarks"),
                                      ),
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
                                  side: BorderSide(
                                      color: Colors.redAccent, width: 1),
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
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
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
                                            selected: value1inspb1,
                                            value: value1inspb1,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb1 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf1,
                                            value: value1inspaf1,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf1 = value!;
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
                                            selected: value1inspb2,
                                            value: value1inspb2,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb2 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf2,
                                            value: value1inspaf2,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf2 = value!;
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
                                            selected: value1inspb3,
                                            value: value1inspb3,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb3 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf3,
                                            value: value1inspaf3,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf3 = value!;
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
                                  side: BorderSide(
                                      color: Colors.redAccent, width: 1),
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
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
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
                                            selected: value1inspb4,
                                            value: value1inspb4,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb4 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf4,
                                            value: value1inspaf4,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf4 = value!;
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
                                            selected: value1inspb5,
                                            value: value1inspb5,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb5 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf5,
                                            value: value1inspaf5,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf5 = value!;
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
                                            selected: value1inspb6,
                                            value: value1inspb6,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb6 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf6,
                                            value: value1inspaf6,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf6 = value!;
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
                                            selected: value1inspb7,
                                            value: value1inspb7,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb7 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf7,
                                            value: value1inspaf7,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf7 = value!;
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
                                            selected: value1inspb8,
                                            value: value1inspb8,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb8 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf8,
                                            value: value1inspaf8,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf8 = value!;
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
                                            selected: value1inspb9,
                                            value: value1inspb9,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb9 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf9,
                                            value: value1inspaf9,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf9 = value!;
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
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
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
                                            selected: value1inspb10,
                                            value: value1inspb10,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb10 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf10,
                                            value: value1inspaf10,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf10 = value!;
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
                                            selected: value1inspb11,
                                            value: value1inspb11,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb11 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf11,
                                            value: value1inspaf11,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf11 = value!;
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
                                            selected: value1inspb12,
                                            title: const Text('OK'),
                                            value: value1inspb12,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb12 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf12,
                                            value: value1inspaf12,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf12 = value!;
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
                                            selected: value1inspb13,
                                            value: value1inspb13,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb13 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf13,
                                            value: value1inspaf13,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf13 = value!;
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
                                            selected: value1inspb14,
                                            value: value1inspb14,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb14 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf14,
                                            value: value1inspaf14,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf14 = value!;
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
                                            selected: value1inspb15,
                                            value: value1inspb15,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb15 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf15,
                                            value: value1inspaf15,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf15 = value!;
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
                                            selected: value1inspb16,
                                            value: value1inspb16,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspb16 = value!;
                                              });
                                            },
                                          ),
                                        ),
                                        Flexible(
                                          child: CheckboxListTile(
                                            title: const Text('OK'),
                                            selected: value1inspaf16,
                                            value: value1inspaf16,
                                            activeColor: Colors.red,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                value1inspaf16 = value!;
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
            ))
        : Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: const Text(
                'Pending Job Cards',
                style: const TextStyle(color: Colors.black),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                },
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: _body(),
          );
  }

  _fetchPendingInstallationJobCard() async {
    String url = await Config.getBaseUrl();

    HttpClientResponse response = await Config.getRequestObject(
        url + 'trackerjobcard/pending/$_hrid?type=0', Config.get);
    if (response != null) {
      print(response);

      response.transform(utf8.decoder).transform(LineSplitter()).listen((data) {
        var jsonResponse = json.decode(data);

        print(jsonResponse);
        setState(() {
          pendinInstJobCardsJson = jsonResponse;
        });
        var list = jsonResponse as List;
        List<JobCard> result = list.map<JobCard>((json) {
          return JobCard.fromJson(json);
        }).toList();
        if (result.isNotEmpty) {
          setState(() {
            result.sort((a, b) => a.customername!
                .toLowerCase()
                .compareTo(b.customername!.toLowerCase()));

            _pendingInstJobCards = result;
            noJobCards = _pendingInstJobCards.length;
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

  _fetchDeviceDetails() async {
    String url = await Config.getBaseUrl();
    HttpClientResponse response = await Config.getRequestObject(
        url + 'tracker/device/?cc=$_costcenterid&tech=$_hrid&param=0',
        Config.get);
    if (response != null) {
      print(response);
      response.transform(utf8.decoder).transform(LineSplitter()).listen((data) {
        var jsonResponse = json.decode(data);
        setState(() {
          devicesJson = jsonResponse;
        });
        print(jsonResponse);
        var list = jsonResponse as List;
        List<Device> result = list.map<Device>((json) {
          return Device.fromJson(json);
        }).toList();
        if (result.isNotEmpty) {
          setState(() {
            result.sort((a, b) =>
                a.serialno!.toLowerCase().compareTo(b.serialno!.toLowerCase()));

            _devicesJson = result;
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
            technicians = result;
            print(technicians);
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
            content: Text('Are you sure you want to submit'),
            actions: <Widget>[
              FlatButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(ctx);
                  }),
              FlatButton(
                  onPressed: () async {
                    Navigator.pop(ctx);

                    String chassisno = _chasisno.text.trim();
                    String trackerlocation = _trackerLocation.text.trim();
                    String vehiclecolor = _vehcolor.text.trim();
                    String engineno = _engineno.text.trim();

                    String region = _region.text.trim();

                    String remarks = _remarks.text.trim();
                    String dateinput = _dateinput.text;
                    LinearProgressIndicator dial = LinearProgressIndicator();

                    String demoUrl = await Config.getBaseUrl();
                    Uri url = Uri.parse(demoUrl + 'tracker/');
                    print(url);

                    final response = await http.post(url,
                        headers: <String, String>{
                          'Content-Type': 'application/json',
                        },
                        body: jsonEncode(<String, dynamic>{
                          "trackertypeid": 0,
                          "trackerlocation": trackerlocation,
                          "chassisno": chassisno,
                          "vehiclecolor": vehiclecolor,
                          "region": region,
                          "jobcardid": _jobCardId,
                          "imeinoid": _imeinoId != null ? _imeinoId : 0,
                          "backupimeinoid": _imeinoId1 != null ? _imeinoId1 : 0,
                          "backupimeino2id":
                              _imeinoId2 != null ? _imeinoId2 : 0,
                          "devicenoid": _devicenoId != null ? _devicenoId : 0,
                          "backupdevicenoid":
                              _devicenoId1 != null ? _devicenoId1 : 0,
                          "backupdeviceno2id":
                              _devicenoId2 != null ? _devicenoId2 : 0,
                          "value1inspb1": value1inspb1,
                          "value1inspb2": value1inspb2,
                          "value1inspb3": value1inspb3,
                          "value1inspb4": value1inspb4,
                          "value1inspb5": value1inspb5,
                          "value1inspb6": value1inspb6,
                          "value1inspb7": value1inspb7,
                          "value1inspb8": value1inspb8,
                          "value1inspb9": value1inspb9,
                          "value1inspb10": value1inspb10,
                          "value1inspb11": value1inspb11,
                          "value1inspb12": value1inspb12,
                          "value1inspb13": value1inspb13,
                          "value1inspb14": value1inspb14,
                          "value1inspb15": value1inspb15,
                          "value1inspb16": value1inspb16,
                          "value1inspaf1": value1inspaf1,
                          "value1inspaf2": value1inspaf2,
                          "value1inspaf3": value1inspaf3,
                          "value1inspaf4": value1inspaf4,
                          "value1inspaf5": value1inspaf5,
                          "value1inspaf6": value1inspaf6,
                          "value1inspaf7": value1inspaf7,
                          "value1inspaf8": value1inspaf8,
                          "value1inspaf9": value1inspaf9,
                          "value1inspaf10": value1inspaf10,
                          "value1inspaf11": value1inspaf11,
                          "value1inspaf12": value1inspaf12,
                          "value1inspaf13": value1inspaf13,
                          "value1inspaf14": value1inspaf14,
                          "value1inspaf15": value1inspaf15,
                          "value1inspaf16": value1inspaf16,
                          "trackerlocation": _location,
                          "remarks": remarks == null ? "" : remarks,
                          "userid": _userid,
                        }));

                    print(jsonEncode(<String, dynamic>{
                      "trackertypeid": 0,
                      "trackerlocation": trackerlocation,
                      "chassisno": chassisno,
                      "vehiclecolor": vehiclecolor,
                      "region": region,
                      "jobcardid": _jobCardId,
                      "imeinoid": _imeinoId != null ? _imeinoId : 0,
                      "backupimeinoid": _imeinoId1 != null ? _imeinoId1 : 0,
                      "backupimeino2id": _imeinoId2 != null ? _imeinoId2 : 0,
                      "devicenoid": _devicenoId != null ? _devicenoId : 0,
                      "backupdevicenoid":
                          _devicenoId1 != null ? _devicenoId1 : 0,
                      "backupdeviceno2id":
                          _devicenoId2 != null ? _devicenoId2 : 0,
                      "value1inspb1": value1inspb1,
                      "value1inspb2": value1inspb2,
                      "value1inspb3": value1inspb3,
                      "value1inspb4": value1inspb4,
                      "value1inspb5": value1inspb5,
                      "value1inspb6": value1inspb6,
                      "value1inspb7": value1inspb7,
                      "value1inspb8": value1inspb8,
                      "value1inspb9": value1inspb9,
                      "value1inspb10": value1inspb10,
                      "value1inspb11": value1inspb11,
                      "value1inspb12": value1inspb12,
                      "value1inspb13": value1inspb13,
                      "value1inspb14": value1inspb14,
                      "value1inspb15": value1inspb15,
                      "value1inspb16": value1inspb16,
                      "value1inspaf1": value1inspaf1,
                      "value1inspaf2": value1inspaf2,
                      "value1inspaf3": value1inspaf3,
                      "value1inspaf4": value1inspaf4,
                      "value1inspaf5": value1inspaf5,
                      "value1inspaf6": value1inspaf6,
                      "value1inspaf7": value1inspaf7,
                      "value1inspaf8": value1inspaf8,
                      "value1inspaf9": value1inspaf9,
                      "value1inspaf10": value1inspaf10,
                      "value1inspaf11": value1inspaf11,
                      "value1inspaf12": value1inspaf12,
                      "value1inspaf13": value1inspaf13,
                      "value1inspaf14": value1inspaf14,
                      "value1inspaf15": value1inspaf15,
                      "value1inspaf16": value1inspaf16,
                      // "trackerlocation": _location,
                      "remarks": remarks,
                      "userid": _userid,
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

  Widget getListTile(val) {
    return ListTile(
      leading: Text(val['serialno'] ?? ''),
      title: Text(val['description'] ?? ''),
    );
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
      content: Text("You have successfully created  a Tracker"),
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

  _body() {
    if (_pendingInstJobCards != null && _pendingInstJobCards.isNotEmpty) {
      _pendingInstJobCards.forEach((jobcard) {
        String customerName = jobcard.customername!;
      });

      return _listViewBuilder(_pendingInstJobCards);
    }
    return Center(
      child: Text('No pending job cards'),
    );
  }

  _listViewBuilder(List<JobCard> data) {
    return ListView.builder(
        itemBuilder: (bc, i) {
          JobCard jobCard = data.elementAt(i);
          String name = jobCard.customername!;
          int? id = jobCard.id;
          String? date = jobCard.date;
          String? customername = jobCard.customername;
          String? finphone = jobCard.finphone;
          String? custphone = jobCard.custphone;
          String? vehreg = jobCard.vehreg;
          String? location = jobCard.location;
          String? docno = jobCard.docno;
          String? vehmodel = jobCard.vehmodel;
          int? notracker = jobCard.notracker;
          String? remarks = jobCard.remarks;
          String? finname = jobCard.finname;

          print("Jobcard id :::: ${jobCard.id}");

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name != null ? 'Name: $name' : 'Name: Undefined'),
                  ],
                ),
                onTap: () {
                  setState(() {
                    isSelectedJobCard = false;
                  });

                  SessionPreferences().setSelectedJobCard(jobCard);
                  _jobCardId = jobCard.id;
                  _custName = jobCard.customername;
                  _custPhone = jobCard.custphone;
                  _vehreg = jobCard.vehreg;
                  _vehmodel = jobCard.vehmodel;
                  _location = jobCard.location;
                },
              ),
            ),
          );
        },
        itemCount: data.length);
  }

  void _checkDuplicates() {
    // print(_imeinoId);
    // print((_imeinoId == _imeinoId));
    // if ((_imeinoId != null) == true) {
    //   if ((_imeinoId == _imeinoId1) == true ||
    //       (_imeinoId == _imeinoId2) == true ||
    //       (_imeinoId == _devicenoId) == true ||
    //       (_imeinoId == _devicenoId1) == true ||
    //       (_imeinoId == _devicenoId2) == true) {
    //     // Fluttertoast.showToast(msg: 'Duplicate value for IME1 Device');
    //     setState(() {
    //       currentFormState = 0;
    //     });
    //   } else {
    //     setState(() {
    //       currentFormState = 5;
    //     });
    //   }
    // }
    // if ((_imeinoId1 != null) == true) {
    //   if ((_imeinoId1 == _imeinoId) == true ||
    //       (_imeinoId1 == _imeinoId2) == true ||
    //       (_imeinoId1 == _devicenoId) == true ||
    //       (_imeinoId1 == _devicenoId1) == true ||
    //       (_imeinoId1 == _devicenoId2) == true) {
    //     setState(() {
    //       currentFormState = 0;
    //     });
    //     // Fluttertoast.showToast(msg: 'Duplicate values for BACKUP1 IMEI NUMBER');
    //   } else {
    //     setState(() {
    //       currentFormState = 5;
    //     });
    //   }
    // }
    // if ((_imeinoId2 != null) == true) {
    //   if ((_imeinoId2 == _imeinoId) == true ||
    //       (_imeinoId2 == _imeinoId1) == true ||
    //       (_imeinoId2 == _devicenoId) == true ||
    //       (_imeinoId2 == _devicenoId1) == true ||
    //       (_imeinoId2 == _devicenoId2) == true) {
    //     setState(() {
    //       currentFormState = 0;
    //     });
    //     // Fluttertoast.showToast(msg: 'Duplicate values for BACKUP2 IMEI NUMBER');
    //   } else {
    //     setState(() {
    //       currentFormState = 5;
    //     });
    //   }
    // }
    // if ((_devicenoId != null) == true) {
    //   if ((_devicenoId == _imeinoId) == true ||
    //       (_devicenoId == _imeinoId1) == true ||
    //       (_devicenoId == _imeinoId2) == true ||
    //       (_devicenoId == _devicenoId1) == true ||
    //       (_devicenoId == _devicenoId2) == true) {
    //     setState(() {
    //       currentFormState = 0;
    //     });
    //     // Fluttertoast.showToast(msg: 'Duplicate values for Device Number');
    //   } else {
    //     setState(() {
    //       currentFormState = 5;
    //     });
    //   }
    // }
    // if ((_devicenoId1 != null) == true) {
    //   if ((_devicenoId1 == _imeinoId) == true ||
    //       (_devicenoId1 == _imeinoId1) == true ||
    //       (_devicenoId1 == _imeinoId2) == true ||
    //       (_devicenoId1 == _devicenoId) == true ||
    //       (_devicenoId1 == _devicenoId2) == true) {
    //     setState(() {
    //       currentFormState = 0;
    //     });
    //     // Fluttertoast.showToast(
    //     // msg: 'Duplicate values for BACKUP1 DEVICE NUMBER');
    //   } else {
    //     setState(() {
    //       currentFormState = 5;
    //     });
    //   }
    // }
    // if ((_devicenoId2 != null) == true) {
    //   if ((_devicenoId2 == _imeinoId) == true ||
    //       (_devicenoId2 == _imeinoId1) == true ||
    //       (_devicenoId2 == _imeinoId2) == true ||
    //       (_devicenoId2 == _devicenoId) == true ||
    //       (_devicenoId2 == _devicenoId1) == true) {
    //     setState(() {
    //       currentFormState = 0;
    //     });
    //     // Fluttertoast.showToast(
    //     // msg: 'Duplicate values for BACKUP2 DEVICE NUMBER');
    //   } else {
    //     setState(() {
    //       currentFormState = 5;
    //     });
    //   }
    // }
  }
}
