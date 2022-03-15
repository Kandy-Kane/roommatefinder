import 'package:flutter/material.dart';
import 'package:roommatefinder/reference.dart';
import 'package:roommatefinder/register.dart';
import 'package:roommatefinder/signIn.dart';
// import 'package:mongo_dart/mongo_dart.dart';
import 'mongodbAttempt/constants.dart';
import 'mongodbAttempt/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';

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

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(40.0),
              child: AppBar(
                backgroundColor: Color.fromARGB(255, 4, 43, 5),
                // title: const Text('Manhattan College Roommate Finder'),
                bottom: TabBar(
                  tabs: [
                    Text("Register", style: TextStyle(fontSize: 30)),
                    Text("Sign In", style: TextStyle(fontSize: 30))
                  ],
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.greenAccent),
                  indicatorColor: Colors.greenAccent,
                ),
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://www.nycgo.com/images/venues/48911/manhattancollege_riverdale_manhattan_nyc_campus_quad_20171219_d55e2fe8-c71e-4f45-a1bac0d540892e0c_89284a94-9d78-4741-a2e6885d22ee1231__large.jpg"),
                      fit: BoxFit.fill)),
              child: TabBarView(
                children: [Register(), SignIn()],
              ),
            ),
          )),
    );
  }
}
