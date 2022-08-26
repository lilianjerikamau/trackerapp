// ignore_for_file: unused_field

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter/material.dart';
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:trackerapp/models/jobcardmodels.dart';
import 'package:trackerapp/models/usermodels.dart';
import 'package:trackerapp/models/invoicemodels.dart';
import 'package:trackerapp/screens/create_installation_job_card.dart';
import 'package:trackerapp/screens/create_maintenace_job_card.dart';
import 'package:trackerapp/screens/create_tracker.dart';
import 'package:trackerapp/screens/login_screen.dart';
import 'package:trackerapp/screens/job_card_details.dart';
import 'package:trackerapp/screens/maintain_tracker.dart';
import 'package:trackerapp/screens/selectcompany.dart';
import 'package:trackerapp/screens/sidemenu/side_menu.dart';
import 'package:trackerapp/utils/config.dart' as Config;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../utils/config.dart';

class Home extends StatefulWidget {
  final id;
  final date;
  final customername;
  final finphone;
  final custphone;
  final vehreg;
  final location;
  final docno;
  final vehmodel;
  final notracker;
  final remarks;
  final finname;
  const Home({
    key,
    this.id,
    this.date,
    this.customername,
    this.finphone,
    this.custphone,
    this.vehreg,
    this.location,
    this.docno,
    this.vehmodel,
    this.notracker,
    this.remarks,
    this.finname,
  });
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? _userid;
  int? _hrid;
  bool? _isTechnician;
  List<JobCard> _pendingInstJobCards = [];
  List<JobCard> _pendingAllJobCards = [];
  List<JobCard> _pendingMaintJobCards = [];
  List<Invoice>? _invoiceList = [];
  Invoice? _selectedInvoice = null;
  String _message = 'Specify a date range and press search';
  int? noJobCards;
  int? _noPaidInvoices;
  int? _noUnPaidInvoices;
  int? noInstJobCards;
  int? noMaintJobCards;
  List pendinInstJobCardsJson = [];
  late String _imgFromSettings,
      _companyURL,
      _companyDomainUrl,
      _versionFromServer;
  late List<Widget> _actions;
  List<String> _jobCardTypes = ['Installation', 'Maintenance']; // Option 2
  late String _dropDownValue; // Option 2
  static DateFormat _format = DateFormat('yyyy-MM-dd');
  DateFormat _forDisplay = new DateFormat('d/MMMM/yyyy');
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _invTotalController = new TextEditingController();
  TextEditingController _fromDateController = new TextEditingController();
  TextEditingController _toDateController = new TextEditingController();
  TextEditingController _grandTTController = new TextEditingController();
  static var myDate = DateTime.parse(DateTime.now().toString());
  static var fromDate = myDate.subtract(Duration(days: 30));
  static var toDate = DateTime.now();
  static String formattedFromDate = _format.format(fromDate);
  static String formattedToDate = _format.format(toDate);
  var _formattedFromDate = DateTime.parse(formattedFromDate);
  var _formattedToDate = DateTime.parse(formattedToDate);
  // final prefix1.Stack<Widget> _pageStack = prefix1.Stack();
  // PackageInfo _packageInfo;
  // Widget _body;
  // int _buildNumberFromServer;
  bool _loggedIn = false, _loggingIn = false;

  // _companySettingsDone = false;
  // _updateDialogShown = false;
  final _userNameInput = TextEditingController();
  final _passWordInput = TextEditingController();

  BuildContext? _context;
  late User _loggedInUser;
  final double _monthlyTotal = 0;
  final _homeScaffoldKey = GlobalKey<ScaffoldState>();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  // List<JobCard>? _pendingInstJobCards;
  @override
  void initState() {
    print("Testing format string");
    // print("100".formatedNumber());

    SessionPreferences().getLoggedInStatus().then((loggedIn) {
      if (loggedIn == null) {
        setState(() {
          _loggedIn = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          print("logged in is null");
        });
      } else {
        setState(() {
          _loggedIn = loggedIn;
          print("logged in not null");
        });
        if (loggedIn) {
          SessionPreferences().getLoggedInUser().then((user) {
            setState(() {
              _loggedInUser = user;
              _userid = user.id;
              _hrid = user.hrid;
              _isTechnician = user.technician;
            });
            _fetchPendingInstallationJobCard();
            _fetchPendingMaintJobCard();
            _fetchAllPendingJobCard();
            _fetchUnpaidInvoices();
            _fetchPaidInvoices();
          });
        }
      }
    });

    super.initState();
    bool isJobCardDetailTapped = false;
    bool isJobCardMaintDetailTapped = false;
    bool isPaidJobCard = false;
    bool isUnPaidJobCard = false;
    bool isAllJobCardTapped = false;
  }

  // _readVersionFromServer() async {
  //   String baseUrl = await Config.getBaseUrl();
  //   HttpClientResponse response = await Config.getRequestObject(
  //       baseUrl + '$_packageInfo.version', Config.get);
  //   if (response != null) {
  //     response.transform(utf8.decoder).listen((data) {
  //       var jsonResponse = json.decode(data);
  //       setState(() {
  //         _versionFromServer = jsonResponse['versionName'];
  //         _buildNumberFromServer = jsonResponse['versionCode'];
  //       });
  //     });
  //   }
  // }
  bool isJobCardDetailTapped = false;
  bool isPaidJobCard = false;
  bool isUnPaidJobCard = false;
  bool isJobCardMaintDetailTapped = false;
  bool isAllJobCardTapped = false;
  @override
  Widget build(BuildContext context) {
    String? client = _selectedInvoice != null ? _selectedInvoice!.client : '';
    Object? invoceamt =
        _selectedInvoice != null ? _selectedInvoice!.invoiceamt : 0;
    return isJobCardDetailTapped == false &&
            isJobCardMaintDetailTapped == false &&
            isAllJobCardTapped == false &&
            isPaidJobCard == false &&
            isUnPaidJobCard == false
        ? Scaffold(
            backgroundColor: Colors.grey[200],
            drawer: SideMenu(),
            appBar: AppBar(
              title: const Text(
                'Home',
                style: const TextStyle(color: Colors.black),
              ),
              leading: Builder(
                builder: (BuildContext context) {
                  return RotatedBox(
                    quarterTurns: 1,
                    child: IconButton(
                      icon: const Icon(
                        Icons.bar_chart_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  );
                },
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: _isTechnician == false
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              side: BorderSide(
                                color: Colors.red,
                                width: 1, //<-- SEE HERE
                              ),
                            ),
                            elevation: 2,
                            margin: EdgeInsets.all(12.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Job Card Details',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Icon(
                                            Icons.work,
                                            color: Colors.red,
                                          ),
                                        ]),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isJobCardDetailTapped = true;
                                        });

                                        _fetchPendingInstallationJobCard();
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.pending),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Pending :$noJobCards",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.check),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Approved : 0",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith()),
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isPaidJobCard = true;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.monetization_on),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              _noPaidInvoices != null
                                                  ? "Paid Invoices : $_noPaidInvoices"
                                                  : "Paid Invoices : 0",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith()),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isUnPaidJobCard = true;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.money_off_rounded),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              _noUnPaidInvoices != null
                                                  ? "Unpaid Invoices : $_noUnPaidInvoices"
                                                  : "Unpaid Invoices : 0",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith()),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              side: BorderSide(
                                color: Colors.red,
                                width: 1, //<-- SEE HERE
                              ),
                            ),
                            elevation: 2,
                            margin: EdgeInsets.all(12.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Installation Job Card',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CreateJobCard()),
                                                );
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.red,
                                              )),
                                        ]),
                                  ),
                                  SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0)),
                              side: BorderSide(
                                color: Colors.red,
                                width: 1, //<-- SEE HERE
                              ),
                            ),
                            elevation: 2,
                            margin: EdgeInsets.all(12.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Maintenance Job Card',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          MaintainJobCard()),
                                                );
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.red,
                                              )),
                                        ]),
                                  ),
                                  SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            side: BorderSide(
                              color: Colors.red,
                              width: 1, //<-- SEE HERE
                            ),
                          ),
                          elevation: 2,
                          margin: EdgeInsets.all(12.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Tracker Details',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        Icon(
                                          Icons.track_changes_rounded,
                                          color: Colors.red,
                                        ),
                                      ]),
                                ),
                                SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isAllJobCardTapped = true;
                                      });
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.pending_actions),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("Pending Approval :$noJobCards",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith()),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isJobCardDetailTapped = true;
                                      });
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.pending),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            "Pending Installation :$noInstJobCards",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith()),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isJobCardMaintDetailTapped = true;
                                      });
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.pending_outlined),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            "Pending Maintenance : $noMaintJobCards",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith()),
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            side: BorderSide(
                              color: Colors.red,
                              width: 1, //<-- SEE HERE
                            ),
                          ),
                          elevation: 2,
                          margin: EdgeInsets.all(12.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Installation Tracker',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        CreateTracker()),
                                              );
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.red,
                                            )),
                                      ]),
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                            side: BorderSide(
                              color: Colors.red,
                              width: 1, //<-- SEE HERE
                            ),
                          ),
                          elevation: 2,
                          margin: EdgeInsets.all(12.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Maintenance Tracker',
                                            style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            )),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MaintainTracker()),
                                              );
                                            },
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.red,
                                            )),
                                      ]),
                                ),
                                SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
        : isJobCardDetailTapped == true
            ? Scaffold(
                backgroundColor: Colors.grey[200],
                appBar: AppBar(
                  title: const Text(
                    'Pending Installation Job Cards',
                    style: const TextStyle(color: Colors.black),
                  ),
                  leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                  ),
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                ),
                body: _body(),
              )
            : isJobCardMaintDetailTapped == true
                ? Scaffold(
                    backgroundColor: Colors.grey[200],
                    appBar: AppBar(
                      title: const Text(
                        'Pending Maintenance Job Cards',
                        style: const TextStyle(color: Colors.black),
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                    ),
                    body: _body1(),
                  )
                : isAllJobCardTapped == true
                    ? Scaffold(
                        backgroundColor: Colors.grey[200],
                        appBar: AppBar(
                          title: const Text(
                            'Pending All Job Cards',
                            style: const TextStyle(color: Colors.black),
                          ),
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Home()),
                              );
                            },
                          ),
                          backgroundColor: Colors.white,
                          elevation: 0.0,
                        ),
                        body: _body2())
                    : isPaidJobCard == true
                        ? WillPopScope(
                            onWillPop: () async {
                              if (_selectedInvoice != null) {
                                setState(() {
                                  _selectedInvoice = null;
                                });
                                return false;
                              } else if (_invoiceList != null) {
                                setState(() {
                                  _invoiceList = null;
                                });
                                return false;
                              }
                              return true;
                            },
                            child: Scaffold(
                                appBar: AppBar(
                                  leading: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Home()),
                                      );
                                    },
                                  ),
                                  title: Text(_selectedInvoice != null
                                      ? 'Selected Invoice'
                                      : 'Invoice History'),
                                ),
                                body: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(15.0),
                                  child: Column(
                                    children: <Widget>[
                                      Form(
                                        key: _formKey,
                                        child: Container(
                                          padding: EdgeInsets.all(10.0),
                                          color: Colors.white70,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  child: DateTimeField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide()),
                                                    labelText: 'From Date'),
                                                format: _format,
                                                onShowPicker: (ctx, currVal) {
                                                  return showDatePicker(
                                                      context: ctx,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime.now());
                                                },
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Enter from Date';
                                                  }
                                                  return null;
                                                },
                                                controller: _fromDateController,
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    String toDate =
                                                        _toDateController.text;
                                                    if (toDate.isNotEmpty) {
                                                      DateTime toDt =
                                                          _format.parse(toDate);
                                                      if (value.isAfter(toDt)) {
                                                        setState(() {
                                                          _fromDateController
                                                              .clear();
                                                        });
                                                        showDialog(
                                                            context: context,
                                                            builder: (ctx) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Wrong input'),
                                                                content: Text(
                                                                    'From date cannot come after to date'),
                                                                actions: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            ctx);
                                                                      },
                                                                      child: Text(
                                                                          'Ok'))
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    }
                                                  }
                                                },
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Expanded(
                                                  child: DateTimeField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide()),
                                                    labelText: 'To Date'),
                                                format: _format,
                                                onShowPicker: (ctx, currVal) {
                                                  return showDatePicker(
                                                      context: ctx,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime.now());
                                                },
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Enter to Date';
                                                  }
                                                  return null;
                                                },
                                                controller: _toDateController,
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    String fromDate =
                                                        _fromDateController
                                                            .text;
                                                    if (fromDate.isNotEmpty) {
                                                      DateTime fmDt = _format
                                                          .parse(fromDate);
                                                      if (value
                                                          .isBefore(fmDt)) {
                                                        setState(() {
                                                          _toDateController
                                                              .clear();
                                                        });
                                                        showDialog(
                                                            context: context,
                                                            builder: (ctx) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Wrong input'),
                                                                content: Text(
                                                                    'From date cannot come after to date'),
                                                                actions: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            ctx);
                                                                      },
                                                                      child: Text(
                                                                          'Ok'))
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    }
                                                  }
                                                },
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(child: _itemsBody()),
                                      _baseView()
                                    ],
                                  ),
                                )),
                          )
                        : WillPopScope(
                            onWillPop: () async {
                              if (_selectedInvoice != null) {
                                setState(() {
                                  _selectedInvoice = null;
                                });
                                return false;
                              } else if (_invoiceList != null) {
                                setState(() {
                                  _invoiceList = null;
                                });
                                return false;
                              }
                              return true;
                            },
                            child: Scaffold(
                                appBar: AppBar(
                                  leading: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const Home()),
                                      );
                                    },
                                  ),
                                  title: Text(_selectedInvoice != null
                                      ? 'Selected Invoice'
                                      : 'Invoice History'),
                                ),
                                body: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.all(15.0),
                                  child: Column(
                                    children: <Widget>[
                                      Form(
                                        key: _formKey,
                                        child: Container(
                                          padding: EdgeInsets.all(10.0),
                                          color: Colors.white70,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  child: DateTimeField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide()),
                                                    labelText: 'From Date'),
                                                format: _format,
                                                onShowPicker: (ctx, currVal) {
                                                  return showDatePicker(
                                                      context: ctx,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime.now());
                                                },
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Enter from Date';
                                                  }
                                                  return null;
                                                },
                                                controller: _fromDateController,
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    String toDate =
                                                        _toDateController.text;
                                                    if (toDate.isNotEmpty) {
                                                      DateTime toDt =
                                                          _format.parse(toDate);
                                                      if (value.isAfter(toDt)) {
                                                        setState(() {
                                                          _fromDateController
                                                              .clear();
                                                        });
                                                        showDialog(
                                                            context: context,
                                                            builder: (ctx) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Wrong input'),
                                                                content: Text(
                                                                    'From date cannot come after to date'),
                                                                actions: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            ctx);
                                                                      },
                                                                      child: Text(
                                                                          'Ok'))
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    }
                                                  }
                                                },
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              Expanded(
                                                  child: DateTimeField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide()),
                                                    labelText: 'To Date'),
                                                format: _format,
                                                onShowPicker: (ctx, currVal) {
                                                  return showDatePicker(
                                                      context: ctx,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(1900),
                                                      lastDate: DateTime.now());
                                                },
                                                validator: (value) {
                                                  if (value == null) {
                                                    return 'Enter to Date';
                                                  }
                                                  return null;
                                                },
                                                controller: _toDateController,
                                                onChanged: (value) {
                                                  if (value != null) {
                                                    String fromDate =
                                                        _fromDateController
                                                            .text;
                                                    if (fromDate.isNotEmpty) {
                                                      DateTime fmDt = _format
                                                          .parse(fromDate);
                                                      if (value
                                                          .isBefore(fmDt)) {
                                                        setState(() {
                                                          _toDateController
                                                              .clear();
                                                        });
                                                        showDialog(
                                                            context: context,
                                                            builder: (ctx) {
                                                              return AlertDialog(
                                                                title: Text(
                                                                    'Wrong input'),
                                                                content: Text(
                                                                    'From date cannot come after to date'),
                                                                actions: <
                                                                    Widget>[
                                                                  FlatButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            ctx);
                                                                      },
                                                                      child: Text(
                                                                          'Ok'))
                                                                ],
                                                              );
                                                            });
                                                      }
                                                    }
                                                  }
                                                },
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(child: _itemsBody1()),
                                      _baseView1()
                                    ],
                                  ),
                                )),
                          );
  }

  _fetchAllPendingJobCard() async {
    String url = await Config.getBaseUrl();

    HttpClientResponse response = await Config.getRequestObject(
        url + 'trackerjobcard/pending/$_hrid?type=3', Config.get);
    if (response != null) {
      print(response);
      response.transform(utf8.decoder).transform(LineSplitter()).listen((data) {
        var jsonResponse = json.decode(data);
        setState(() {
          pendinInstJobCardsJson = jsonResponse;
        });
        print(jsonResponse);
        var list = jsonResponse as List;
        List<JobCard> result = list.map<JobCard>((json) {
          return JobCard.fromJson(json);
        }).toList();
        if (result.isNotEmpty) {
          setState(() {
            result.sort((a, b) => a.customername!
                .toLowerCase()
                .compareTo(b.customername!.toLowerCase()));

            _pendingAllJobCards = result;
            noJobCards = _pendingAllJobCards.length;
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

  _listViewBuilder1(List<JobCard> data) {
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
                leading: Icon(Icons.pending),
                title: Text(name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name != null ? 'Name: $name' : 'Name: Undefined'),
                    // Text('Name balance: $bal'),
                    // Text('PDCheque balance: $pdBal'),
                    // Text('Available Credit: $creditLimit')
                  ],
                ),
                onTap: () {
                  // SessionPreferences().setSelectedJobCard(jobCard);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PendingInstJobCardDetails(
                              id: id,
                              date: date,
                              customername: customername,
                              finphone: finphone,
                              custphone: custphone,
                              vehreg: vehreg,
                              location: location,
                              docno: docno,
                              vehmodel: vehmodel,
                              notracker: notracker,
                              remarks: remarks,
                              finname: finname,
                            )),
                  );
                },
              ),
            ),
          );
        },
        itemCount: data.length);
  }

  _body1() {
    if (_pendingMaintJobCards != null && _pendingMaintJobCards.isNotEmpty) {
      _pendingMaintJobCards.forEach((jobcard) {
        String customerName = jobcard.customername!;
      });

      return _listViewBuilder1(_pendingMaintJobCards);
    }
    return Center(
      child: Text('No pending job cards'),
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
        setState(() {
          pendinInstJobCardsJson = jsonResponse;
        });
        print(jsonResponse);
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
            noInstJobCards = _pendingInstJobCards.length;
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

  _listViewBuilder2(List<JobCard> data) {
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
                leading: Icon(Icons.pending),
                title: Text(name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name != null ? 'Name: $name' : 'Name: Undefined'),
                    // Text('Name balance: $bal'),
                    // Text('PDCheque balance: $pdBal'),
                    // Text('Available Credit: $creditLimit')
                  ],
                ),
                onTap: () {
                  // SessionPreferences().setSelectedJobCard(jobCard);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PendingInstJobCardDetails(
                              id: id,
                              date: date,
                              customername: customername,
                              finphone: finphone,
                              custphone: custphone,
                              vehreg: vehreg,
                              location: location,
                              docno: docno,
                              vehmodel: vehmodel,
                              notracker: notracker,
                              remarks: remarks,
                              finname: finname,
                            )),
                  );
                },
              ),
            ),
          );
        },
        itemCount: data.length);
  }

  _body2() {
    if (_pendingAllJobCards != null && _pendingAllJobCards.isNotEmpty) {
      _pendingAllJobCards.forEach((jobcard) {
        String customerName = jobcard.customername!;
      });

      return _listViewBuilder2(_pendingAllJobCards);
    }
    return Center(
      child: Text('No pending job cards'),
    );
  }

  _fetchPendingMaintJobCard() async {
    String url = await Config.getBaseUrl();

    HttpClientResponse response = await Config.getRequestObject(
        url + 'trackerjobcard/pending/$_hrid?type=1', Config.get);
    if (response != null) {
      print(response);
      response.transform(utf8.decoder).transform(LineSplitter()).listen((data) {
        var jsonResponse = json.decode(data);
        setState(() {
          pendinInstJobCardsJson = jsonResponse;
        });
        print(jsonResponse);
        var list = jsonResponse as List;
        List<JobCard> result = list.map<JobCard>((json) {
          return JobCard.fromJson(json);
        }).toList();
        if (result.isNotEmpty) {
          setState(() {
            result.sort((a, b) => a.customername!
                .toLowerCase()
                .compareTo(b.customername!.toLowerCase()));

            _pendingMaintJobCards = result;
            noMaintJobCards = _pendingMaintJobCards.length;
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

  _fetchUnpaidInvoices() async {
    String url = await getBaseUrl();
    HttpClientResponse response = await getRequestObject(
      url +
          '/tracker/pendinginvoice/69?from=$formattedFromDate&to=$formattedToDate',
      get,
    );
    if (response != null) {
      response.transform(utf8.decoder).listen((data) {
        var jsonResponse = json.decode(data);
        var list = jsonResponse as List;
        setState(() {
          formattedFromDate != null ? print(formattedFromDate) : "null";
          print(formattedToDate);
          _noUnPaidInvoices = list.length;
        });
        List<Invoice> objs = list.map<Invoice>((json) {
          return Invoice.fromJson(json);
        }).toList();
        print('Data fetched: -> $jsonResponse');
        Invoice invObj = objs.first;
        setState(() {
          _selectedInvoice = invObj;
        });
      });
    }
  }

  _fetchPaidInvoices() async {
    String url = await getBaseUrl();
    HttpClientResponse response = await getRequestObject(
      url +
          '/tracker/paidinvoice/69?from=$formattedFromDate&to=$formattedToDate',
      get,
    );
    if (response != null) {
      response.transform(utf8.decoder).listen((data) {
        var jsonResponse = json.decode(data);
        var list = jsonResponse as List;
        setState(() {
          formattedFromDate != null ? print(formattedFromDate) : "null";
          print(formattedToDate);
          _noPaidInvoices = list.length;
        });
        List<Invoice> objs = list.map<Invoice>((json) {
          return Invoice.fromJson(json);
        }).toList();
        print('Data fetched: -> $jsonResponse');
        Invoice invObj = objs.first;
        setState(() {
          _selectedInvoice = invObj;
        });
      });
    }
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
                leading: Icon(Icons.pending),
                title: Text(name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(name != null ? 'Name: $name' : 'Name: Undefined'),
                    // Text('Name balance: $bal'),
                    // Text('PDCheque balance: $pdBal'),
                    // Text('Available Credit: $creditLimit')
                  ],
                ),
                onTap: () {
                  // SessionPreferences().setSelectedJobCard(jobCard);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PendingInstJobCardDetails(
                              id: id,
                              date: date,
                              customername: customername,
                              finphone: finphone,
                              custphone: custphone,
                              vehreg: vehreg,
                              location: location,
                              docno: docno,
                              vehmodel: vehmodel,
                              notracker: notracker,
                              remarks: remarks,
                              finname: finname,
                            )),
                  );
                },
              ),
            ),
          );
        },
        itemCount: data.length);
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

  _itemsBody() {
    if (_invoiceList != null) {
      if (_invoiceList!.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemBuilder: (ctx, i) {
                Invoice item = _invoiceList!.elementAt(i);
                int? id = item.id;
                String? vegreg = item.vegreg;
                String? client = item.client;
                int? balance = item.balance;
                int? invoiceamt = item.invoiceamt;
                return Container(
                  color: Colors.white70,
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text('Customer: $client'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Vehicle Registration: $vegreg'),
                              Text('Invoice Amount: ' + invoiceamt.toString()),
                            ],
                          ),
                          onTap: () async {
                            setState(() {
                              formattedFromDate != null
                                  ? print(formattedFromDate)
                                  : "null";
                              print(formattedToDate);
                              _noUnPaidInvoices = _invoiceList!.length;
                            });
                            // ProgressDialog dialog =
                            //     new ProgressDialog(_context);
                            // dialog.style(message: 'Loading invoice ... ');
                            // dialog.show();
                            String url = await getBaseUrl();
                            HttpClientResponse response =
                                await getRequestObject(
                              url +
                                  'https://erpqa.netrixbiz.com/AnchorERP/fused/api/tracker/paidinvoice/69?from=$formattedFromDate&to=$formattedToDate',
                              get,
                            );
                            if (response != null) {
                              response.transform(utf8.decoder).listen((data) {
                                var jsonResponse = json.decode(data);
                                var list = jsonResponse as List;
                                List<Invoice> objs = list.map<Invoice>((json) {
                                  return Invoice.fromJson(json);
                                }).toList();
                                print('Data fetched: -> $jsonResponse');
                                Invoice invObj = objs.first;
                                setState(() {
                                  _selectedInvoice = invObj;
                                  _noPaidInvoices = _invoiceList!.length;
                                });
                              });
                            }
                          },
                        ),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
              itemCount: _invoiceList!.length),
        );
      } else {
        // _message = 'No transactions found for the date range specified';
      }
    }
    return Center(
        // child: Text(_message),
        );
  }

  _baseView() {
    // if (_invoiceList != null && _invoiceList!.isNotEmpty) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: TextFormField(
    //       controller: _grandTTController,
    //       enabled: false,
    //       decoration: InputDecoration(
    //           border: OutlineInputBorder(borderSide: BorderSide()),
    //           labelText: 'Total invoice for time period'),
    //     ),
    //   );
    // }
    return CupertinoButton(
        color: Colors.red,
        child: Text('Search'),
        onPressed: () async {
          int? salesRepId = _loggedInUser.hrid;
          if (_formKey.currentState!.validate()) {
            String fromDate = _fromDateController.text;
            String toDate = _toDateController.text;
            ProgressDialog d = ProgressDialog(
              context, type: ProgressDialogType.Normal,
              isDismissible: true,

              /// your body here
              customBody: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                backgroundColor: Colors.white,
              ),
            );
            d.style(message: 'Fetching items ... ');
            d.show();
            String url = await getBaseUrl();
            HttpClientResponse response = await getRequestObject(
                url +
                    'tracker/paidinvoice/$salesRepId?from=$fromDate&to=$toDate',
                get);
            print(fromDate);
            print(toDate);

            d.hide();
            if (response != null) {
              response
                  .transform(utf8.decoder)
                  .transform(LineSplitter())
                  .listen((data) {
                var jsonResponse = json.decode(data);
                var list = jsonResponse as List;
                List<Invoice> items = list.map<Invoice>((json) {
                  return Invoice.fromJson(json);
                }).toList();
                double tt = 0;
                // items.forEach((item) {
                //   tt += item.invoiceamt;
                // });
                setState(() {
                  _invoiceList = items;
                  _grandTTController.text =
                      NumberFormat.currency(symbol: '').format(tt);
                });
              });
            }
          }
        });
  }

  _listViewBuilder3(List<Invoice> details) {
    return Container(
      color: Colors.white70,
      child: ListView.builder(
          itemBuilder: (ctx, i) {
            Invoice detail = details.elementAt(i);
            String ttPrice =
                NumberFormat.currency(symbol: '').format(detail.invoiceamt);
            String unitPrice =
                NumberFormat.currency(symbol: '').format(detail.balance);
            String? qty = detail.mobile;
            String? itemName = detail.client;
            int? discount = detail.balance;
            return Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                    elevation: 15.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      color: Colors.blueGrey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Item description: $itemName',
                              style: TextStyle(fontSize: 15)),
                          Text('Unit Price: $unitPrice',
                              style: TextStyle(fontSize: 15)),
                          Text('Ordered quantity: $qty',
                              style: TextStyle(fontSize: 15)),
                          Text('Discount amount: $discount',
                              style: TextStyle(fontSize: 15)),
                          //  Text('Total Price: $ttPrice',
                          //    style: TextStyle(fontSize: 15)),
                          //  SizedBox(height: 20,),
                          Text('Paybill No: $discount',
                              style: TextStyle(fontSize: 15)),
                          Text('Account No: $itemName',
                              style: TextStyle(fontSize: 15))
                        ],
                      ),
                    )));
          },
          itemCount: details.length),
    );
  }

  _itemsBody1() {
    if (_invoiceList != null) {
      if (_invoiceList!.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemBuilder: (ctx, i) {
                Invoice item = _invoiceList!.elementAt(i);
                int? id = item.id;
                String? vegreg = item.vegreg;
                String? client = item.client;
                int? balance = item.balance;
                int? invoiceamt = item.invoiceamt;
                return Container(
                  color: Colors.white70,
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 10,
                        child: ListTile(
                          leading: Icon(Icons.monetization_on),
                          title: Text('Customer: $client'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Vehicle Registration: $vegreg'),
                              Text('Invove Amount: ' + invoiceamt.toString()),
                            ],
                          ),
                          onTap: () async {
                            setState(() {});
                            // ProgressDialog dialog =
                            //     new ProgressDialog(_context);
                            // dialog.style(message: 'Loading invoice ... ');
                            // dialog.show();
                            String url = await getBaseUrl();
                            HttpClientResponse response =
                                await getRequestObject(
                              url +
                                  'https://erpqa.netrixbiz.com/AnchorERP/fused/api/tracker/pendinginvoice/69?from=$formattedFromDate&to=$formattedToDate',
                              get,
                            );
                            if (response != null) {
                              response.transform(utf8.decoder).listen((data) {
                                var jsonResponse = json.decode(data);
                                var list = jsonResponse as List;
                                setState(() {
                                  formattedFromDate != null
                                      ? print(formattedFromDate)
                                      : "null";
                                  print(formattedToDate);
                                  _noUnPaidInvoices = list.length;
                                });
                                List<Invoice> objs = list.map<Invoice>((json) {
                                  return Invoice.fromJson(json);
                                }).toList();
                                print('Data fetched: -> $jsonResponse');
                                Invoice invObj = objs.first;
                                setState(() {
                                  _selectedInvoice = invObj;
                                });
                              });
                            }
                          },
                        ),
                      ),
                      Divider()
                    ],
                  ),
                );
              },
              itemCount: _invoiceList!.length),
        );
      } else {
        // _message = 'No transactions found for the date range specified';
      }
    }
    return Center(
        // child: Text(_message),
        );
  }

  _baseView1() {
    // if (_invoiceList != null && _invoiceList!.isNotEmpty) {
    //   return Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: TextFormField(
    //       controller: _grandTTController,
    //       enabled: false,
    //       decoration: InputDecoration(
    //           border: OutlineInputBorder(borderSide: BorderSide()),
    //           labelText: 'Total invoice for time period'),
    //     ),
    //   );
    // }
    return CupertinoButton(
        color: Colors.red,
        child: Text('Search'),
        onPressed: () async {
          int? salesRepId = _loggedInUser.hrid;
          if (_formKey.currentState!.validate()) {
            String fromDate = _fromDateController.text;
            String toDate = _toDateController.text;
            ProgressDialog d = ProgressDialog(
              context, type: ProgressDialogType.Normal,
              isDismissible: true,

              /// your body here
              customBody: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
                backgroundColor: Colors.white,
              ),
            );
            d.style(message: 'Fetching items ... ');
            d.show();
            String url = await getBaseUrl();
            HttpClientResponse response = await getRequestObject(
                url +
                    'tracker/pendinginvoice/$salesRepId?from=$fromDate&to=$toDate',
                get);
            print(fromDate);
            print(toDate);

            d.hide();
            if (response != null) {
              response
                  .transform(utf8.decoder)
                  .transform(LineSplitter())
                  .listen((data) {
                var jsonResponse = json.decode(data);
                var list = jsonResponse as List;
                List<Invoice> items = list.map<Invoice>((json) {
                  return Invoice.fromJson(json);
                }).toList();
                double tt = 0;
                // items.forEach((item) {
                //   tt += item.invoiceamt;
                // });
                setState(() {
                  _invoiceList = items;
                  _grandTTController.text =
                      NumberFormat.currency(symbol: '').format(tt);
                });
              });
            }
          }
        });
  }

  _listViewBuilder4(List<Invoice> details) {
    return Container(
      color: Colors.white70,
      child: ListView.builder(
          itemBuilder: (ctx, i) {
            Invoice detail = details.elementAt(i);
            String ttPrice =
                NumberFormat.currency(symbol: '').format(detail.invoiceamt);
            String unitPrice =
                NumberFormat.currency(symbol: '').format(detail.balance);
            String? qty = detail.mobile;
            String? itemName = detail.client;
            int? discount = detail.balance;
            return Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                    elevation: 15.0,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      color: Colors.blueGrey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text('Item description: $itemName',
                              style: TextStyle(fontSize: 15)),
                          Text('Unit Price: $unitPrice',
                              style: TextStyle(fontSize: 15)),
                          Text('Ordered quantity: $qty',
                              style: TextStyle(fontSize: 15)),
                          Text('Discount amount: $discount',
                              style: TextStyle(fontSize: 15)),
                          //  Text('Total Price: $ttPrice',
                          //    style: TextStyle(fontSize: 15)),
                          //  SizedBox(height: 20,),
                          Text('Paybill No: $discount',
                              style: TextStyle(fontSize: 15)),
                          Text('Account No: $itemName',
                              style: TextStyle(fontSize: 15))
                        ],
                      ),
                    )));
          },
          itemCount: details.length),
    );
  }
}
