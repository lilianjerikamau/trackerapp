import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trackerapp/screens/create_job_card.dart';
import 'package:trackerapp/screens/create_tracker.dart';
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
          icon: const Icon(Icons.home),
          title: const Text("Home"),
        ),
        TabNavigationItem(
          page: CreateTracker(),
          icon: const Icon(Icons.track_changes_rounded),
          title: const Text("Install Tracker"),
        ),
        TabNavigationItem(
          page: CreateJobCard(),
          icon: const Icon(Icons.work),
          title: const Text("Create Job-Card"),
        ),
      ];
}
