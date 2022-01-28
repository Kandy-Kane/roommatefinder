import 'package:flutter/material.dart';
import 'package:roommatefinder/profilePage.dart';
import 'package:roommatefinder/reference.dart';

class TabBarDemo extends StatelessWidget {
  const TabBarDemo({Key? key}) : super(key: key);

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
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
                Tab(icon: Icon(Icons.ac_unit)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          body: const TabBarView(
            children: [
              profilePage(),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.ac_unit),
            ],
          ),
        ),
      ),
    );
  }
}
