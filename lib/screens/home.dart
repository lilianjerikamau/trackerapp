// ignore_for_file: unused_field

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:trackerapp/models/usermodels.dart';
import 'package:trackerapp/screens/create_job_card.dart';
import 'package:trackerapp/screens/create_tracker.dart';
import 'package:trackerapp/screens/login_screen.dart';
import 'package:trackerapp/screens/selectcompany.dart';
import 'package:trackerapp/screens/sidemenu/side_menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            });
          });
        }
      }
    });
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 300,
            width: 500,
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.red, width: 0.5),
                  borderRadius: BorderRadius.circular(5)),
              //Wrap with IntrinsicHeight
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // child: Padding(
                    // padding: const EdgeInsets.all(10.0),

                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(20, 30, 80, 20),
                                child: Text(
                                  'Job Cards',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(160, 30, 0, 20),
                                child: GestureDetector(
                                  onTap: (() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateJobCard()),
                                    );
                                  }),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Divider(color: Colors.red),
                          const SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            child: const Padding(
                              padding: EdgeInsets.fromLTRB(0, 20, 330, 20),
                              child: Text(
                                "Pending : ",
                              ),
                            ),
                          ),
                          const Divider(color: Colors.grey),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 330, 20),
                            child: Text("Approved : "),
                          ),
                          const Divider(color: Colors.grey),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 330, 20),
                            child: const Text("Installed : "),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        color: Colors.red,
                      ),
                      width: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // const SizedBox(
          //   height: 30,
          // ),
          SizedBox(
              height: 200,
              width: 500,
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.red, width: 0.5),
                    borderRadius: BorderRadius.circular(5)),
                //Wrap with IntrinsicHeight
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // child: Padding(
                      // padding: const EdgeInsets.all(10.0),

                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 30, 80, 20),
                                  child: const Text(
                                    'Tracker    ',
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(160, 30, 0, 20),
                                  child: GestureDetector(
                                    onTap: (() {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateTracker()),
                                      );
                                    }),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const Divider(color: Colors.red),
                            const SizedBox(
                              height: 5,
                            ),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 330, 10),
                              child: const Text(
                                "Pending :",
                              ),
                            ),
                            const Divider(color: Colors.grey),
                            const Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 330, 10),
                              child: const Text("Approved :"),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: Colors.red,
                        ),
                        width: 5,
                      ),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
