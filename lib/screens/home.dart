import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:trackerapp/screens/sidemenu/side_menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
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

                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 30, 80, 20),
                          child: Text(
                            'Job Cards',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 330, 20),
                          child: Text(
                            "Pending : ",
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 330, 20),
                          child: Text("Approved : "),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 330, 20),
                          child: Text("Installed : "),
                        ),
                      ],
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

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 30, 80, 20),
                            child: Text(
                              'Trackers',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 330, 20),
                            child: Text(
                              "Pending :",
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 330, 20),
                            child: Text("Approved :"),
                          ),
                        ],
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
