import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:trackerapp/models/financiermodels.dart';
import 'package:trackerapp/models/technicianmodels.dart';
import 'package:trackerapp/models/usermodels.dart';
import 'package:trackerapp/screens/home.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:trackerapp/screens/login_screen.dart';
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
import 'package:camera/camera.dart';

class CreateJobCard extends StatefulWidget {
  final custID;
  final custName;
  final financierID;
  final financierName;

  const CreateJobCard(
      {key, this.custID, this.custName, this.financierID, this.financierName})
      : super(key: key);
  _CreateJobCard createState() => _CreateJobCard();
}

const TWO_PI = 3.14 * .6;
List<String> selectedCategory = [];

List<String> listOfValue = ['Bank', 'Individual'];
List techniciansJson = [];
List customersJson = [];
List technicians = [];

class _CreateJobCard extends State<CreateJobCard> {
  late User _loggedInUser;
  List<CameraDescription>? cameras; //list out the camera available
  CameraController? controller; //controller for camera
  XFile? image; //for captured image

  int? _userid;
  int? _custid;
  int? _hrid;
  String? _username;
  String? _costcenter;
  String? loanofficerName;
  String? loanofficerEmail;
  String? loanofficerPhone;
  String? vehicleReg;
  String? chassisNo;
  String? carModel;
  String? vehicleType;
  String? vehicleColor;
  String? engineNo;
  String? custName;
  String? custPhone;
  bool _loggedIn = false;
  String? remarks;
  String? installationLocation;
  Customer? _selectedCustomer = null;
  Financier? _selectedFinancier = null;
  int? customerid;

  static late var _custName;
  // static late var _custEmail;
  static late var _custPhone;
  static late var _salesrepId = null;
  static late var _salesrepName = null;
  static late var _installationBranch = null;
  static late var noTracker = null;
  static late var _techName;
  static late var _techId;
  static late var _financierEmail;
  static late var _financierPhone;
  static late var custid;
  static late var financierid;
  static late var _financierName;
  void _toggle() {
    setState(() {
      isExistingClient = !isExistingClient;
    });
  }

  void _toggleFinancier() {
    setState(() {
      isExistingFinancier = !isExistingFinancier;
    });
  }

  @override
  void initState() {
    loadCamera();
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(dateTime);
    _dateinput.text = formattedDate; //set the initial value of text field

    financierid = null;
    _financierName = null;
    custid = null;
    _financierEmail = null;
    _financierPhone = null;
    _custName = null;
    // _custEmail = null;
    _custPhone = null;
    _techName = null;
    _techId = null;
    SessionPreferences().getSelectedFinancier().then((financier) {
      setState(() {
        _selectedFinancier = financier;
      });
    });

    SessionPreferences().getSelectedCustomer().then((customer) {
      setState(() {
        _selectedCustomer = customer;
      });
    });
    // customerid = widget.custID;
    // _custName = widget.custName;
    // financierid = widget.custID;
    // _financierName = widget.custName;
    isBankSelected = false;
    isFinancierSelected = false;
    iscameraopen = false;
    // isExistingClient = true;
    // print(customerid);

    SessionPreferences().getLoggedInUser().then((user) {
      setState(() {
        _loggedInUser = user;
        _userid = user.id;
        _hrid = user.hrid;
        _costcenter = user.branchname;
        _username = user.fullname;
      });
      _fetchCustomers();
    });

    _fetchTechnicians();
    super.initState();
  }

  loadCamera() async {
    cameras = await availableCameras();
    if (cameras != null) {
      controller = CameraController(cameras![0], ResolutionPreset.max);
      //cameras[0] = first camera, change to 1 to another camera

      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    } else {
      print("NO any camera found");
    }
  }

  bool _searchmode = false;
  late BuildContext _context;
  List<Financier>? _items;
  // late User _loggedInUser;
  TextEditingController _itemDescController = new TextEditingController();

  String? _searchString;
  final _userNameInput = TextEditingController();
  final _passWordInput = TextEditingController();
  TextEditingController _searchController = new TextEditingController();
  final _loanofficername = TextEditingController();
  final _loanofficerphone = TextEditingController();
  final _loanofficeremail = TextEditingController();
  final _vehiclereg = TextEditingController();
  final _chassisno = TextEditingController();
  final _carmodel = TextEditingController();
  final _vehicletype = TextEditingController();
  final _vehiclecolor = TextEditingController();
  final _engineno = TextEditingController();
  final _custname = TextEditingController();
  final _custphone = TextEditingController();
  final _custEmail = TextEditingController();
  // final _financierid = TextEditingController();
  // final _customerid = TextEditingController();
  final _customertypeid = TextEditingController();
  final _notracker = TextEditingController();
  final _fuelsensor = TextEditingController();
  final _location = TextEditingController();
  final _installationdate = TextEditingController();
  final _remarks = TextEditingController();
  TextEditingController _dateinput = TextEditingController();
// User? _loggedInUser;
  List<Financier>? _financiers;
  List<Customer>? _customers;
  // List<Technician>? technicians;
  String _message = 'Search';

  // late final custID;
  // late final custName;
  // TextEditingController _searchController = TextEditingController();
  // TextEditingController _itemDescController = new TextEditingController();

  bool _isEnable = false;
  var _selectedValue = null;
  var _selectedInstaller = null;
  var _selectedAccount = 'Individual';
  String? _dropdownError;
  late int? loansNumber = null;
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();
  final _formKey16 = GlobalKey<FormState>();

  bool isLoading = false;
  bool isOtherEnabled = false;
  bool isOtherEnabled2 = false;
  bool isOtherEnabled3 = false;
  bool? isBankSelected;
  bool? isFinancierSelected;
  bool? iscameraopen;
  bool isExistingClient = false;
  bool isExistingFinancier = false;
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
    return isBankSelected == false && isFinancierSelected == false
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
                              percentageComplete = 50;
                            }
                            break;
                          case 1:
                            form = _formKey16.currentState;
                            if (currentForm == 1) {
                              currentForm = 0;
                              percentageComplete = 100;
                            }
                            break;
                          case 2:
                            form = _formKey16.currentState;
                            if (currentForm == 2) {
                              currentForm = 1;
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
                              currentForm = 2;
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                    "Make sure all required fields are filled"),
                                duration: Duration(seconds: 3),
                              ));
                            }
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
                            form = _formKey16.currentState;
                            if (form.validate()) {
                              form.save();
                              currentForm = 2;
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
                          case 2:
                            _submit();
                        }
                      });
                    },
                    icon: Icon(currentForm == 2
                        ? Icons.upload_rounded
                        : Icons.arrow_forward),
                    label: Text(currentForm == 2 ? "finish" : "next"),
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
                                'Create Installation Job Card',
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 1.0),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 0,
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
                                      left: 20, right: 20, top: 10, bottom: 30),
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                          value: _selectedAccount,
                                          isExpanded: true,
                                          onChanged: (String? value) {
                                            _toggleFinancier();
                                            setState(() {
                                              _selectedAccount = value!;
                                              if (_selectedAccount ==
                                                  'Individual') {
                                                setState(() {
                                                  isBankSelected = false;
                                                });
                                              } else if (_selectedAccount ==
                                                  'Bank') {
                                                setState(() {
                                                  isBankSelected = true;
                                                });
                                              }
                                            });
                                          },
                                          onSaved: (String? value) {
                                            setState(() {
                                              _selectedAccount = value!;
                                            });
                                          },
                                          validator: (value) {
                                            if (value != null) {
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
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        _selectedAccount == 'Bank'
                                            ? Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Financier Name",
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                            .copyWith(
                                                                color:
                                                                    Colors.red),
                                                      )
                                                    ],
                                                  ),
                                                  TextFormField(
                                                    readOnly:
                                                        _selectedAccount ==
                                                                'Individual'
                                                            ? false
                                                            : true,
                                                    initialValue:
                                                        _selectedAccount ==
                                                                'Individual'
                                                            ? ""
                                                            : _financierName,
                                                    enabled:
                                                        isBankSelected == true
                                                            ? true
                                                            : false,
                                                    onSaved: (value) => {
                                                      unloadCustomer(),
                                                    },
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                "Enter financier's name"),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Loan Officer Name",
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                            .copyWith(
                                                                color:
                                                                    Colors.red),
                                                      )
                                                    ],
                                                  ),
                                                  TextFormField(
                                                    validator: (value) => value!
                                                                .isEmpty &&
                                                            _selectedAccount ==
                                                                'Bank'
                                                        ? "This field is required"
                                                        : null,
                                                    controller:
                                                        _loanofficername,
                                                    onSaved: (value) => {},
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                "Enter Loan Officer's name"),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Loan Officer Phone",
                                                        overflow: TextOverflow
                                                            .ellipsis,
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
                                                            .copyWith(
                                                                color:
                                                                    Colors.red),
                                                      )
                                                    ],
                                                  ),
                                                  TextFormField(
                                                    validator: (value) =>
                                                        _selectedAccount ==
                                                                'Bank'
                                                            ? value!.isEmpty ||
                                                                    value.length <
                                                                            10 ==
                                                                        true ||
                                                                    value.length >
                                                                            10 ==
                                                                        true
                                                                ? "Enter valid phone number (0712345678)"
                                                                : null
                                                            : null,
                                                    controller:
                                                        _loanofficerphone,
                                                    onSaved: (value) => {
                                                      unloadCustomer(),
                                                    },
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText:
                                                                "Enter Loan Officer's Phone"),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Client Name",
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _toggle();
                                                });
                                              },
                                              child: Text(
                                                "Existing Client",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2!
                                                    .copyWith(
                                                        color: Colors.red),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        isExistingClient == true
                                            ? SearchableDropdown(
                                                hint: const Text(
                                                  "Existing Client",
                                                ),

                                                isExpanded: true,
                                                onChanged: (value) {
                                                  _selectedValue = value;
                                                  _custid = value != null
                                                      ? value['custid']
                                                      : null;
                                                  _custName = value != null
                                                      ? value['company']
                                                      : null;
                                                  _custPhone = value != null
                                                      ? value['mobile']
                                                      : null;
                                                  // _custEmail = value != null
                                                  //     ? ['email']
                                                  //     : null;
                                                  setState(() {
                                                    // _selectedValue = value!;
                                                  });
                                                  print(_selectedValue);
                                                  print(_custName);
                                                  print(_custid);
                                                  print(_custPhone);
                                                  _dropdownError = null;
                                                },

                                                // isCaseSensitiveSearch: true,
                                                searchHint: const Text(
                                                  'Select Existing Client ',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                items: customersJson.map((val) {
                                                  return DropdownMenuItem(
                                                    child: getListTile(val),
                                                    value: val,
                                                  );
                                                }).toList(),
                                              )
                                            : TextFormField(
                                                controller: _custname,
                                                validator: (value) => value!
                                                            .isEmpty &&
                                                        isExistingClient ==
                                                            false
                                                    ? "This field is required"
                                                    : null,
                                                onSaved: (value) => {custName},
                                                keyboardType:
                                                    TextInputType.name,
                                                decoration: const InputDecoration(
                                                    hintText:
                                                        "Enter client's name"),
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
                                          controller: _custphone,
                                          // initialValue: isExistingClient == true
                                          //     ? _custPhone
                                          //     : null,
                                          validator: (value) => isExistingClient ==
                                                  false
                                              ? value!.isEmpty
                                                  ? "Select Existing Customer or Enter phone number"
                                                  : value.length < 10 == true ||
                                                          value.length > 10 ==
                                                              true
                                                      ? "Enter valid phone number (0712345678)"
                                                      : null
                                              : null,
                                          readOnly: isExistingClient == true
                                              ? true
                                              : false,
                                          // initialValue: financierid == null
                                          //     ? ""
                                          //     : _financierPhone,
                                          onSaved: (value) => {loanofficerName},
                                          keyboardType: TextInputType.phone,
                                          decoration: const InputDecoration(
                                              hintText: "e.g 0711223344"),
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
                                              "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(color: Colors.red),
                                            )
                                          ],
                                        ),
                                        TextFormField(
                                          controller: _custEmail,
                                          readOnly: isExistingClient == true
                                              ? true
                                              : false,
                                          onSaved: (value) =>
                                              {loanofficerEmail},
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                              hintText: "Enter client's email"),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ))
                          ])),
                      Form(
                          key: _formKey16,
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
                                      left: 20, right: 20, top: 10, bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Vehicle Details",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
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
                                        controller: _vehiclereg,
                                        validator: (value) => value!.isEmpty
                                            ? "This field is required"
                                            : null,
                                        onSaved: (value) => {vehicleReg},
                                        keyboardType: TextInputType.name,
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
                                        controller: _carmodel,
                                        validator: (value) => value!.isEmpty
                                            ? "This field is required"
                                            : null,
                                        onSaved: (value) => {carModel},
                                        keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Vehicle Model"),
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
                                        ],
                                      ),
                                      TextFormField(
                                        controller: _chassisno,
                                        onSaved: (value) => {chassisNo},
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
                                        ],
                                      ),
                                      TextFormField(
                                        controller: _engineno,
                                        onSaved: (value) => {engineNo},
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
                                        ],
                                      ),
                                      TextFormField(
                                        controller: _vehiclecolor,
                                        onSaved: (value) => {vehicleColor},
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
                                        controller: _location,
                                        validator: (value) => value!.isEmpty
                                            ? "This field is required"
                                            : null,
                                        onSaved: (value) =>
                                            {installationLocation},
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
                                            "No of Trackers",
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
                                        controller: _notracker,
                                        validator: (value) => value!.isEmpty
                                            ? "This field is required"
                                            : null,
                                        onSaved: (value) => {noTracker},
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                            hintText:
                                                "Enter Vehicle No of Trackers"),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Preferred Installer",
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
                                          "Enter Preferred Installer",
                                        ),
                                        isExpanded: true,
                                        onChanged: (value) {
                                          (value) => value == null
                                              ? 'field required'
                                              : null;
                                          _selectedInstaller = value;
                                          _techId = value != null
                                              ? value['empid']
                                              : null;
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
                                          'Select Existing Client ',
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
                                      //   readOnly: true,
                                      //   initialValue: _costcenter,
                                      //   onSaved: (value) => {},
                                      //   keyboardType: TextInputType.number,
                                      //   decoration: const InputDecoration(
                                      //       hintText:
                                      //           "Enter Vehicle No of Trackers"),
                                      // ),
                                      // const SizedBox(
                                      //   height: 10,
                                      // ),
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
                                        value: isOther6,
                                        activeColor: Colors.red,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            isOther6 = value!;
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
                                        onSaved: (value) => {remarks},
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
                                            "Installation Date",
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
                                                DateFormat('dd/MM/yyyy')
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
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
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
            ))
        : isBankSelected == true && isFinancierSelected == false
            ? WillPopScope(
                onWillPop: () async {
                  if (_searchmode) {
                    setState(() {
                      _searchmode = false;
                      _searchString = null;
                    });
                    return false;
                  }
                  return true;
                },
                child: Scaffold(
                  appBar: AppBar(
                    title: _searchmode
                        ? TextFormField(
                            controller: _searchController,
                            decoration: InputDecoration(
                                hintText: 'Search financier company',
                                hintStyle: TextStyle(color: Colors.white)),
                            onChanged: (value) {
                              setState(() {
                                _searchString = value;
                                _fetchFinanciers();
                              });
                            })
                        : Text('Search Financier '),
                    actions: <Widget>[
                      Visibility(
                        visible: !_searchmode,
                        child: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                _searchmode = true;
                              });
                            }),
                      )
                    ],
                  ),
                  body: Container(
                    color: Colors.white,
                    child: _body2(),
                  ),
                ),
              )
            : WillPopScope(
                onWillPop: () async {
                  if (_searchmode) {
                    setState(() {
                      _searchmode = false;
                      _searchString = null;
                    });
                    return false;
                  }
                  return true;
                },
                child: Scaffold(
                    appBar: AppBar(
                      title: _searchmode
                          ? TextFormField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                  hintText: 'Search financier name',
                                  hintStyle: TextStyle(color: Colors.white)),
                              onChanged: (value) {
                                setState(() {
                                  _searchString = value;
                                });
                              })
                          : const Text(
                              'Search Financier by company name,email or phone number'),
                      actions: <Widget>[
                        Visibility(
                          visible: !_searchmode,
                          child: IconButton(
                            icon: Icon(Icons.search),
                            onPressed: () {
                              setState(() {
                                _searchmode = true;
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    body: Container(
                      color: Colors.white,
                      child: _body(),
                    )),
              );
  }

  // late User _loggedInUser;
  // User? _loggedInUser;
  Widget getListTile(val) {
    return ListTile(
      leading: Text(val['mobile'] ?? ''),
      title: Text(val['company'] ?? ''),
      trailing: Text(val['email'] ?? ''),
    );
  }

  _fetchCustomers() async {
    String url = await Config.getBaseUrl();

    HttpClientResponse response = await Config.getRequestObject(
        url + 'trackerjobcard/customer/?type=1&param=', Config.get);
    if (response != null) {
      print(response);
      response.transform(utf8.decoder).transform(LineSplitter()).listen((data) {
        var jsonResponse = json.decode(data);
        setState(() {
          customersJson = jsonResponse;
        });
        print(jsonResponse);
        var list = jsonResponse as List;
        List<Customer> result = list.map<Customer>((json) {
          return Customer.fromJson(json);
        }).toList();
        if (result.isNotEmpty) {
          setState(() {
            result.sort((a, b) =>
                a.company!.toLowerCase().compareTo(b.company!.toLowerCase()));
            _customers = result;
          });
        } else {
          setState(() {
            _message = 'You have not been assigned any customers';
          });
        }
      });
    } else {
      print('response is null ');
    }
  }

  _body() {
    if (_customers != null && _customers!.isNotEmpty) {
      if (_searchString != null && _searchString!.isNotEmpty) {
        List<Customer> searchResults = [];
        _customers!.forEach((customer) {
          String name = customer.company!;
          // String email = customer.custid!;
          if (name.toLowerCase().contains(_searchString!)) {
            searchResults.add(customer);
          }
        });
        return _listViewBuilder(searchResults);
      }
      return _listViewBuilder(_customers!);
    }
    return Center(
      child: Text(_message),
    );
  }

  _listViewBuilder(List<Customer> data) {
    return ListView.builder(
        itemBuilder: (bc, i) {
          Customer customer = data.elementAt(i);
          String name = customer.company!;
          // String email = financier.email!;

          print("Financier id :::: ${customer.custid}");

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
                    // Text('Financier balance: $bal'),
                    // Text('PDCheque balance: $pdBal'),
                    // Text('Available Credit: $creditLimit')
                  ],
                ),
                onTap: () {
                  if (name != null) {
                    setState(() {
                      SessionPreferences().setSelectedCustomer(customer);
                      isFinancierSelected = false;

                      custid = _selectedCustomer!.custid;
                      _custName = _selectedCustomer!.company;
                      setState(() {});
                    });
                    print('custid is $custid');
                    SessionPreferences().getSelectedCustomer().then((customer) {
                      setState(() {
                        _selectedCustomer = customer;
                      });
                    });
                    // print(object)
                    Fluttertoast.showToast(msg: 'Selected Successfully!');
                    // print(customerID);
                  } else {
                    showDialog(
                        context: _context,
                        builder: (bc) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Icon(Icons.error, color: Colors.red),
                                Text('This financier does not exist')
                              ],
                            ),
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
                },
              ),
            ),
          );
        },
        itemCount: data.length);
  }

  unloadCustomer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('customer');
  }

  _fetchFinanciers() async {
    String url = await Config.getBaseUrl();

    HttpClientResponse response = await Config.getRequestObject(
        url + 'trackerjobcard/customer/?type=2&param=$_searchString',
        Config.get);
    if (response != null) {
      print(response);
      response.transform(utf8.decoder).transform(LineSplitter()).listen((data) {
        var jsonResponse = json.decode(data);
        print(jsonResponse);
        var list = jsonResponse as List;
        List<Financier> result = list.map<Financier>((json) {
          return Financier.fromJson(json);
        }).toList();
        if (result.isNotEmpty) {
          // print(result);
          setState(() {
            result.sort((a, b) =>
                a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
            _financiers = result;
            // print(_customers);
          });
        } else {
          setState(() {
            _message = 'You have not been assigned any customers';
          });
        }
      });
    } else {
      print('response is null ');
    }
  }

  _body2() {
    if (_financiers != null && _financiers!.isNotEmpty) {
      if (_searchString != null && _searchString!.isNotEmpty) {
        List<Financier> searchResults = [];
        _financiers!.forEach((financier) {
          String company = financier.name!;
          String code = financier.email!;
          if (company.toLowerCase().contains(_searchString!)) {
            searchResults.add(financier);
          }
        });
        return _listViewBuilder2(searchResults);
      } else {
        setState(() {
          _searchString = '';
        });
      }
      return _listViewBuilder2(_financiers!);
    }
    return Center(
      child: Text(_message),
    );
  }

  _listViewBuilder2(List<Financier> data) {
    return ListView.builder(
        itemBuilder: (bc, i) {
          Financier financier = data.elementAt(i);
          String company = financier.name!;
          // String email = financier.email!;

          // print("Financier id :::: ${customer.custid}");

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.white70,
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(company),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        company != null ? 'Name: $company' : 'Name: Undefined'),
                    // Text('Financier balance: $bal'),
                    // Text('PDCheque balance: $pdBal'),
                    // Text('Available Credit: $creditLimit')
                  ],
                ),
                onTap: () {
                  if (company != null) {
                    String itemDesc = _itemDescController.text.trim();

                    setState(() {
                      SessionPreferences().setSelectedFinancier(financier);
                      isBankSelected = false;

                      financierid = _selectedFinancier!.id;
                      _financierEmail = _selectedFinancier!.email;
                      _financierPhone = _selectedFinancier!.mobile;
                      _financierName = _selectedFinancier!.name;
                      setState(() {});
                    });
                    SessionPreferences()
                        .getSelectedFinancier()
                        .then((financier) {
                      setState(() {
                        _selectedFinancier = financier;
                      });
                    });

                    print('financierid is $financierid');
                    // print(object)
                    Fluttertoast.showToast(msg: 'Selected Successfully!');
                    print('financierid is $financierid');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => CreateJobCard()),
                    // );

                    // print(object)
                    Fluttertoast.showToast(msg: 'Selected Successfully!');
                    // print(customerID);
                  } else {
                    showDialog(
                        context: _context,
                        builder: (bc) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const <Widget>[
                                Icon(Icons.error, color: Colors.red),
                                Text('This financier does not exist')
                              ],
                            ),
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
                },
              ),
            ),
          );
        },
        itemCount: data.length);
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
            _message = 'You have not been assigned any customers';
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
                    String loanofficername = _loanofficername.text.trim();
                    String loanofficerphone = _loanofficerphone.text.trim();

                    String vehiclereg = _vehiclereg.text.trim();
                    String chassisno = _chassisno.text.trim();
                    String carmodel = _carmodel.text.trim();
                    String vehicletype = _vehicletype.text.trim();
                    String vehiclecolor = _vehiclecolor.text.trim();
                    String engineno = _engineno.text.trim();
                    String custname = _custname.text.trim();
                    String custphone = _custphone.text.trim();

                    int notracker = int.parse(_notracker.text);
                    String fuelsensor = _fuelsensor.text.trim();
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
                          "jobcardtypeid": 2,
                          "loanofficername":
                              _selectedAccount == 'Bank' ? loanofficername : "",
                          "loanofficerphone": _selectedAccount == 'Bank'
                              ? loanofficerphone
                              : "",
                          "vehiclereg": vehiclereg,
                          "chassisno": chassisno,
                          "carmodel": carmodel,
                          "vehicletype": vehicletype,
                          "vehiclecolor": vehiclecolor,
                          "engineno": engineno,
                          "custname":
                              isExistingClient == false ? custname : _custName,
                          "custphone": isExistingClient == false
                              ? custphone
                              : "no _custPhone",
                          "financierid": _selectedAccount == 'Individual'
                              ? 0
                              : financierid,
                          "customerid": isExistingClient == true ? _custid : 0,
                          "customertypeid": _selectedAccount == 'Bank' ? 2 : 1,
                          "notracker": notracker,
                          "fuelsensor": isOther6,
                          "location": location,
                          "installationdate": dateinput.toString(),
                          "userid": _userid,
                          "technicianid": 30,
                          "remarks": remarks == null ? "" : remarks
                        }));

                    print(jsonEncode(<String, dynamic>{
                      "jobcardtypeid": 2,
                      "loanofficername":
                          _selectedAccount == 'Bank' ? loanofficername : "",
                      "loanofficerphone":
                          _selectedAccount == 'Bank' ? loanofficerphone : "",
                      "vehiclereg": vehiclereg,
                      "chassisno": chassisno,
                      "carmodel": carmodel,
                      "vehicletype": vehicletype,
                      "vehiclecolor": vehiclecolor,
                      "engineno": engineno,
                      "custname":
                          isExistingClient == false ? custname : _custName,
                      "custphone": isExistingClient == false
                          ? custphone
                          : "no _custPhone",
                      "financierid":
                          _selectedAccount == 'Individual' ? 0 : financierid,
                      "customerid": isExistingClient == true ? _custid : 0,
                      "customertypeid": _selectedAccount == 'Bank' ? 2 : 1,
                      "notracker": notracker,
                      "fuelsensor": isOther6,
                      "location": location,
                      "installationdate": dateinput.toString(),
                      "userid": _userid,
                      "technicianid": _techId,
                      "remarks": remarks != null ? remarks : ""
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
          title: Text('Error'),
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
    content: Text("You have successfully created  a Job Card"),
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
