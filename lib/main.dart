import 'package:flutter/material.dart';
import 'package:trackerapp/screens/tabs/tabspage.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, primaryColor: Colors.white),
      home: TabsPage(selectedIndex: 0),
      debugShowCheckedModeBanner: false,
    );
  }
}
