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
      }
    });
    super.initState();
  }

  bool _loggedIn = false;
  String? _loggedInUser = null;
  BuildContext? _context;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'images/logo.png',
                  height: 150.0,
                  width: 100.0,
                ),
              ),
              color: Colors.red,
            ),
            decoration: new BoxDecoration(
              color: Colors.red,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text('Home', style: TextStyle(color: Colors.black)),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()),
              )
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.track_changes,
              color: Colors.black,
            ),
            title: const Text('Tracker',
                style: TextStyle(
                  color: Colors.black,
                )),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CreateTracker()),
              ),
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.work,
              color: Colors.black,
            ),
            title: const Text('Job-card',
                style: TextStyle(
                  color: Colors.black,
                )),
            onTap: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => CreateTracker()),
              ),
            },
          ),
          const SizedBox(
            height: 150,
          ),
          ListTile(
            hoverColor: Colors.black,
            dense: true,
            visualDensity: VisualDensity(vertical: -4),
            leading: Icon(
              Icons.power_settings_new,
              color: Colors.black,
            ),
            title: Text('Logout'),
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
        ],
      ),
    );
  }
}
