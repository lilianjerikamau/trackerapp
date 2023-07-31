import 'package:flutter/material.dart';
import 'package:trackerapp/screens/home.dart';
import 'package:trackerapp/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(primarySwatch: Colors.red),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
