import 'package:flutter/material.dart';
import 'package:roommatefinder/reference.dart';
import 'package:roommatefinder/register.dart';
import 'package:roommatefinder/signIn.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'mongodbAttempt/constants.dart';
import 'mongodbAttempt/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
