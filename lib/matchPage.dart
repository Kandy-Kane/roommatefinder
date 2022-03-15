import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:developer';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:roommatefinder/main.dart';
import 'package:roommatefinder/profilePage.dart';
import 'package:roommatefinder/user_Firebase.dart';
import 'functions.dart';
import 'package:email_auth/email_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'userClass.dart';
import 'selectedProfilePage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'matchClass.dart';

/*IMPORTANT THING TO NOTE. WHEN DOING A QUERY USING DOT
 NOTATION THE DOT NOTATION HAS TO BE THE FIRST WHERE*/

class matchPage extends StatefulWidget {
  const matchPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _matchPageState createState() => _matchPageState();
}

class _matchPageState extends State<matchPage> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  var collection = FirebaseFirestore.instance.collection('USERS');
  Stream<QuerySnapshot> snaps = FirebaseFirestore.instance
      .collection('USERS')
      .orderBy('name')
      .snapshots();
  var db = Database();
  List<matchUser> allMatches = [];

  @override
  Widget build(BuildContext context) {
    var testMatch = new matchUser(name: "skitle", points: 0);
    var testMatch2 = new matchUser(name: "skitle2", points: 1);

    // allMatches.add(testMatch);
    // allMatches.add(testMatch2);

    // log(allMatches[0].name.toString());

    // var listTest = [1, 2, 3, 4, 5, 6];

    Future<List<String>> getUsersPreferences() async {
      List<String> answers = [];
      var gender;
      var groceries;
      var morningornight;
      var musicPreference;
      var personlity;
      var roomstate;
      var sleeptime;
      var studylocation;
      var temperature;
      var weekends;
      var userID = await db.getUserIDFromUsername(widget.user.username);
      var thisUser = await collection.doc(userID).get();
      gender = thisUser.get('preferences.gender');
      groceries = thisUser.get('preferences.groceries');
      morningornight = thisUser.get('preferences.morningornight');
      musicPreference = thisUser.get('preferences.musicpreference');
      personlity = thisUser.get('preferences.personality');
      roomstate = thisUser.get('preferences.roomstate');
      sleeptime = thisUser.get('preferences.sleeptime');
      studylocation = thisUser.get('preferences.studylocation');
      temperature = thisUser.get('preferences.temperature');
      weekends = thisUser.get('preferences.weekends');

      // print(gender);
      // print(groceries);
      // print(morningornight);
      answers.add(gender);
      answers.add(groceries);
      answers.add(morningornight);
      answers.add(musicPreference);
      answers.add(personlity);
      answers.add(roomstate);
      answers.add(sleeptime);
      answers.add(studylocation);
      answers.add(temperature);
      answers.add(weekends);
      return answers;
    }

    Future<List<matchUser>> createMatches() async {
      var userAnswers = await getUsersPreferences();
      var allUserPoints = <int>[];
      allMatches.clear();
      List<matchUser> allCurrentMatches = [];

      collection.get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          var tempMatch = new matchUser(name: '', points: 0);
          var currentUserPoints = 0;

          if (doc['preferences.gender'] == userAnswers[0]) {
            currentUserPoints++;
          }
          if (doc['preferences.groceries'] == userAnswers[1]) {
            currentUserPoints++;
          }
          if (doc['preferences.morningornight'] == userAnswers[2]) {
            currentUserPoints++;
          }
          if (doc['preferences.musicpreference'] == userAnswers[3]) {
            currentUserPoints++;
          }
          if (doc['preferences.personality'] == userAnswers[4]) {
            currentUserPoints++;
          }
          if (doc['preferences.roomstate'] == userAnswers[5]) {
            currentUserPoints++;
          }
          if (doc['preferences.sleeptime'] == userAnswers[6]) {
            currentUserPoints++;
          }
          if (doc['preferences.studylocation'] == userAnswers[7]) {
            currentUserPoints++;
          }
          if (doc['preferences.temperature'] == userAnswers[8]) {
            currentUserPoints++;
          }
          if (doc['preferences.weekends'] == userAnswers[9]) {
            currentUserPoints++;
          }
          log(doc['name'] +
              ": " +
              'User Points:' +
              currentUserPoints.toString());
          allUserPoints.add(currentUserPoints);
          tempMatch.name = doc['name'];
          tempMatch.points = currentUserPoints;
          log("TEMP MATCH:" +
              tempMatch.name.toString() +
              "/" +
              tempMatch.points.toString());
          allCurrentMatches.add(tempMatch);
          log("length:" + allCurrentMatches.length.toString());

          // print('All User Points: ' + allUserPoints.toList().toString());
        });
        log('All User Points: ' + allUserPoints.toList().toString());
        // log("\nALL MATCHES TEST:\n");
        // allMatches.forEach((element) {
        //   log(element.name.toString() + "/" + element.points.toString());
        // });
        allCurrentMatches.sort(
          (b, a) => a.points.compareTo(b.points),
        );
        log("\nALL MATCHES TEST 2:\n");
        allCurrentMatches.forEach((element) {
          log(element.name.toString() + "/" + element.points.toString());
        });
        log("INSIDE FUNCTION MATCHES: " + allCurrentMatches.length.toString());
        setState(() {
          // allMatches.addAll(allCurrentMatches);
          allMatches.add(allCurrentMatches[0]);
          allMatches.add(allCurrentMatches[1]);
          allMatches.add(allCurrentMatches[2]);
        });
      });
      log("INSIDE FUNCTION MATCHES: " + allCurrentMatches.length.toString());
      return allCurrentMatches;
    }

    return Scaffold(

        // appBar: AppBar(
        //   title: Text("Notes"),
        //   centerTitle: true,
        // ),
        body: Column(
      children: [
        Container(
          child: TextButton(
            child: Text("GET MATCHES"),
            onPressed: () async {
              // var answers = await getUsersPreferences();
              // var allUserPoints = await createMatches();
              // print('ANSWERS:' + answers.toString());
              // print(answers[0]);
              List<matchUser> allnewMatches = await createMatches();
              log('FINAL MATCHES: ' + allnewMatches.length.toString());

              // var snaps2 = await collection
              //     //.where('name', isNotEqualTo: widget.user.name)
              //     .where('preferences.gender', isEqualTo: 'Female')
              //     //.orderBy('name')
              //     .get()
              //     .then((QuerySnapshot querySnapshot) {
              //   querySnapshot.docs.forEach((doc) {
              //     print(doc['email']);
              //   });
              // });
              //print("Type of:" + snaps.runtimeType.toString());

              setState(() {
                // snaps = collection
                //     .where('preferences.gender', isEqualTo: answers[0])
                //     // .where('preferences.morningornight',
                //     //     isEqualTo: answers[2].toString())
                //     // .where('preferences.groceries',
                //     //     isEqualTo: answers[1].toString())
                //     .where('name', isNotEqualTo: widget.user.name)
                //     //.orderBy('name')
                //     .snapshots();

                log("NEW MATCHES:" + allnewMatches.length.toString());
              });
            },
          ),
        ),
        Row(children: [
          Expanded(
              child: TextFormField(
            controller: myController,
            onChanged: (value) async {
              setState(() {
                if (value == "") {
                  snaps = collection
                      //f.where('username', isNotEqualTo: widget.user.username)
                      .orderBy('name')
                      .snapshots();
                } else {
                  snaps = collection
                      .where('name', isGreaterThanOrEqualTo: value)
                      .where('name', isLessThan: value + 'z')
                      .snapshots();
                  // snaps2 = collection
                  //     .where('email', isGreaterThanOrEqualTo: value)
                  //     .where('email', isLessThan: value + 'z')
                  //     .snapshots();
                }
              });
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Search Using Name',
            ),
          )),
          Expanded(
              flex: 0,
              child: IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Change Preferences',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.close),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Text("Major"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: TextFormField(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: TextFormField(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: TextFormField(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: TextFormField(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        child: Text("Submit"),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
              )),
        ]),
        Flexible(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: allMatches.length,
              itemBuilder: (BuildContext context, int index) {
                while (allMatches.length < 3) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                ;
                return Container(
                    height: 50,
                    child: Center(
                      child: Text(allMatches[index].name.toString()),
                    ));
              }),
          // child: StreamBuilder<QuerySnapshot>(
          //   stream: snaps,
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     } else {
          //       return ListView(
          //         children: (snapshot.data!).docs.map((doc) {
          //           return Card(
          //             child: ListTile(
          //               leading: FlutterLogo(size: 56.0),
          //               title: Text(doc['name']),
          //               subtitle: Text(doc['email']),
          //               //trailing: Icon(Icons.more_vert),
          //               onTap: () async {
          //                 var db = Database();
          //                 var selectedUser = await db.queryUser(doc['email']);
          //                 Navigator.of(context).push(MaterialPageRoute(
          //                     builder: (context) => selectedProfilePage(
          //                           user: widget.user,
          //                           selectedUser: selectedUser,
          //                         )));
          //               },
          //             ),
          //           );
          //         }).toList(),
          //       );
          //     }
          //   },
          // ),
        )
            //)
            ),
      ],
    ));
  }
}
