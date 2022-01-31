import 'package:flutter/material.dart';
import 'package:roommatefinder/feedPage.dart';
import 'package:roommatefinder/mongodbAttempt/mongouserClass.dart';
import 'package:roommatefinder/profilePage.dart';
import 'package:roommatefinder/reference.dart';
import 'userClass.dart';

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({Key? key, required this.email, required this.tabUser})
      : super(key: key);

  final String email;

  final User tabUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Profile",
                ),
                Tab(
                  text: "Feed",
                ),
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.ac_unit)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: TabBarView(
            children: [
              profilePage(user: tabUser),
              feedPage(),
              Icon(Icons.directions_bike),
              Icon(Icons.ac_unit),
            ],
          ),
        ),
      ),
    );
  }
}
