import 'package:flutter/material.dart';
import 'package:roommatefinder/feedPage.dart';
import 'package:roommatefinder/messagesPage.dart';
import 'package:roommatefinder/mongodbAttempt/mongouserClass.dart';
import 'package:roommatefinder/profilePage.dart';
import 'package:roommatefinder/matchPage.dart';
import 'package:roommatefinder/quizPage.dart';
import 'package:roommatefinder/reference.dart';
import 'package:roommatefinder/settingsPage.dart';
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
            backgroundColor: Color.fromARGB(255, 4, 43, 5),
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(
                  // text: "Profile",
                  icon: Icon(
                    Icons.portrait,
                    color: Colors.amber,
                    size: 50.0,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.list,
                    color: Colors.amber,
                    size: 50.0,
                  ),
                  // text: "Feed",
                ),
                Tab(
                  iconMargin: EdgeInsets.all(90),
                  // text: "Messages",
                  icon: Icon(
                    Icons.message,
                    color: Colors.amber,
                    size: 50.0,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.handshake,
                    color: Colors.amber,
                    size: 50.0,
                  ),
                  // text: 'Matches',
                ),
              ],
            ),
            title: Container(
                child: Row(
              children: [
                const Text('Roommate Finder'),
                Spacer(),
                InkWell(
                  child: Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 232, 190, 0),
                    size: 30.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => settingsPage(
                              user: tabUser,
                            )));
                  },
                )
              ],
            )),
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
              matchPage(
                user: tabUser,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
