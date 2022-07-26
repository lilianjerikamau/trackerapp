// ignore_for_file: unused_field

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:flutter/material.dart';
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:trackerapp/models/jobcardmodels.dart';
import 'package:trackerapp/models/usermodels.dart';
import 'package:trackerapp/screens/create_installation_job_card.dart';
import 'package:trackerapp/screens/create_maintenace_job_card.dart';
import 'package:trackerapp/screens/create_tracker.dart';
import 'package:trackerapp/screens/login_screen.dart';
import 'package:trackerapp/screens/job_card_details.dart';
import 'package:trackerapp/screens/maintain_tracker.dart';
import 'package:trackerapp/screens/selectcompany.dart';
import 'package:trackerapp/screens/sidemenu/side_menu.dart';
import 'package:trackerapp/utils/config.dart' as Config;

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
  int? noJobCards;
  int? noInstJobCards;
  int? noMaintJobCards;
  List pendinInstJobCardsJson = [];
  late String _pdBal = 'Loading ... ',
      _custBal = 'Loading ... ',
      _creditLimit = 'Loading ... ',
      _availableCredit = 'Loading ... ',
      _fromDate = 'Loading ...',
      _toDate = 'Loading ...',
      _imgFromSettings,
      _companyURL,
      _companyDomainUrl,
      _versionFromServer;
  late List<Widget> _actions;
  List<String> _jobCardTypes = ['Installation', 'Maintenance']; // Option 2
  late String _dropDownValue; // Option 2
  // final prefix1.Stack<Widget> _pageStack = prefix1.Stack();
  // PackageInfo _packageInfo;
  // Widget _body;
  // int _buildNumberFromServer;
  bool _loggedIn = false,
      _loggingIn = false,
      _showPass = true,
      pressedOnce = false,
      _setUpPrint = false,
      _supDialogShown = false;
  // _companySettingsDone = false;
  // _updateDialogShown = false;
  final _userNameInput = TextEditingController();
  final _passWordInput = TextEditingController();

  BuildContext? _context;
  late User _loggedInUser;
  final double _monthlyTotal = 0;
  final _homeScaffoldKey = GlobalKey<ScaffoldState>();
  final _loginFormKey = GlobalKey<FormState>();

  final imageUrl = "/AnchorERP/erp/images/?file=companylogo.png&pfdrid_c=true";
  final imageHttp = "https://";
  // List<JobCard>? _pendingInstJobCards;
  @override
  void initState() {
    print("Testing format string");
    // print("100".formatedNumber());

    SessionPreferences().getLoggedInStatus().then((loggedIn) {
      if (loggedIn == null) {
        setState(() {
          _loggedIn = false;
          Navigator.push(
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
          });
        }
      }
    });

    super.initState();
    bool isJobCardDetailTapped = false;
    bool isJobCardMaintDetailTapped = false;

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
  bool isJobCardMaintDetailTapped = false;
  bool isAllJobCardTapped = false;
  @override
  Widget build(BuildContext context) {
    return isJobCardDetailTapped == false &&
            isJobCardMaintDetailTapped == false &&
            isAllJobCardTapped == false
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
                                        Text("Approved",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle2!
                                                .copyWith()),
                                      ],
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
                                                Navigator.push(
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
                                                Navigator.push(
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
                                              Navigator.push(
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
                                              Navigator.push(
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
              )
            : isJobCardMaintDetailTapped
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
                          Navigator.push(
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
                : Scaffold(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                    ),
                    body: _body2());
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
            // _message = 'You have not been assigned any customers';
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

                  Navigator.push(
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
            // _message = 'You have not been assigned any customers';
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

                  Navigator.push(
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

                  Navigator.push(
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
}
