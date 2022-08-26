import 'package:flutter/material.dart';
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:trackerapp/screens/create_tracker.dart';
import 'package:trackerapp/screens/home.dart';
import 'package:trackerapp/screens/login_screen.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  initState() {
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
      }
    });
    super.initState();
  }

  bool _loggedIn = false;
  String? _loggedInUser = null;
  BuildContext? _context;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: const Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 150,
                      ),
                    ),
                    color: Theme.of(context).primaryColorDark),
                decoration:
                    BoxDecoration(color: Theme.of(context).primaryColorDark),
              ),
              ListTile(
                leading: const Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                title:
                    const Text('Home', style: TextStyle(color: Colors.black)),
                onTap: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  )
                },
              ),
              // ListTile(
              //   leading: const Icon(
              //     Icons.track_changes,
              //     color: Colors.black,
              //   ),
              //   title: const Text('Tracker',
              //       style: TextStyle(
              //         color: Colors.black,
              //       )),
              //   onTap: () => {
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(builder: (context) => CreateTracker()),
              //     ),
              //   },
              // ),
              // ListTile(
              //   leading: const Icon(
              //     Icons.work,
              //     color: Colors.black,
              //   ),
              //   title: const Text('Job-card',
              //       style: TextStyle(
              //         color: Colors.black,
              //       )),
              //   onTap: () => {
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(builder: (context) => CreateTracker()),
              //     ),
              //   },
              // ),
              const SizedBox(
                height: 150,
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: ListTile(
                  hoverColor: Colors.black,
                  dense: true,
                  visualDensity: const VisualDensity(vertical: -4),
                  leading: const Icon(
                    Icons.power_settings_new,
                    color: Colors.black,
                  ),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                    setState(() {
                      SessionPreferences().setLoggedInStatus(false);
                      _loggedIn = false;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
