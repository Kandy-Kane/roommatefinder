import 'package:flutter/material.dart';
import 'package:roommatefinder/reference.dart';
import 'package:roommatefinder/register.dart';
import 'package:roommatefinder/signIn.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Navigation Basics',
    home: MainPage(),
  ));
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Roommate Finder'),
            bottom: TabBar(
              tabs: [Text("Register"), Text("Sign In")],
            ),
          ),
          body: TabBarView(
            children: [Register(), SignIn()],
          ),
        ),
      ),
    );
  }
}
