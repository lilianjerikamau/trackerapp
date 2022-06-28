import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trackerapp/screens/home.dart';
import 'package:trackerapp/screens/login_screen.dart';
import 'package:trackerapp/screens/profile.dart';
import 'package:trackerapp/screens/search.dart';

class TabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;

  TabNavigationItem(
      {required this.page, required this.title, required this.icon});

  static List<TabNavigationItem> get items => [
        TabNavigationItem(
          page: Home(),
          icon: Icon(Icons.home),
          title: Text("Home"),
        ),
        TabNavigationItem(
          page: Search(),
          icon: Icon(Icons.search),
          title: Text("Search"),
        ),
        TabNavigationItem(
          page: LoginPage(),
          icon: Icon(Icons.login_rounded),
          title: Text("Login"),
        ),
      ];
}
