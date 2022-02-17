import 'package:flutter/material.dart';
import 'package:roommatefinder/feedPage.dart';
import 'package:roommatefinder/messagesPage.dart';
import 'package:roommatefinder/mongodbAttempt/mongouserClass.dart';
import 'package:roommatefinder/profilePage.dart';
import 'package:roommatefinder/matchPage.dart';
import 'package:roommatefinder/quizPage.dart';
import 'package:roommatefinder/reference.dart';
import 'userClass.dart';

class TabBarDemo extends StatelessWidget {
  const TabBarDemo(
      {Key? key,
      required this.email,
      required this.tabUser,
      required this.userID})
      : super(key: key);

  final String email;

  final User tabUser;
  final String userID;

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
                Tab(
                  text: "Messages",
                ),
                Tab(
                  text: 'Matches',
                ),
              ],
            ),
            title: const Text('Roommate Finder'),
          ),
          body: TabBarView(
            children: [
              profilePage(user: tabUser),
              feedPage(
                user: tabUser,
              ),
              messagesPage(
                user: tabUser,
                userID: userID,
              ),
              // matchPage(
              //   user: tabUser,
              // ),
              quizPage(user: tabUser)
            ],
          ),
        ),
      ),
    );
  }
}
