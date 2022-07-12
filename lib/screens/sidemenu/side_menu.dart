import 'package:flutter/material.dart';
import 'package:trackerapp/database/sessionpreferences.dart';
import 'package:trackerapp/screens/login_screen.dart';
import 'package:trackerapp/screens/tabs/tabspage.dart';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  late bool _loggedIn = false;
  late String? _loggedInUser = null;
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
                MaterialPageRoute(
                    builder: (context) => TabsPage(selectedIndex: 0)),
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
                MaterialPageRoute(
                    builder: (context) => TabsPage(selectedIndex: 1)),
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
                MaterialPageRoute(
                    builder: (context) => TabsPage(selectedIndex: 2)),
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
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text('Log out?'),
                      content: Text('Are you sure you want to log out?'),
                      actions: <Widget>[
                        FlatButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.pop(ctx);
                            }),
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(ctx);

                              SessionPreferences().setLoggedInStatus(false);
                              _loggedIn = false;
                              _loggedInUser = null;
                              Navigator.push(
                                ctx,
                                MaterialPageRoute(
                                    builder: (ctx) => LoginPage()),
                              );
                            },
                            child: Text('Yes'))
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}
