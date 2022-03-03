import 'dart:developer';

import 'package:flutter/material.dart';
//import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/tabs.dart';
import 'package:roommatefinder/userClass.dart';
import 'package:roommatefinder/user_Firebase.dart';
import 'reference.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class quizPage extends StatefulWidget {
  const quizPage(
      {Key? key, required this.user, required this.email, required this.ID})
      : super(key: key);

  final User user;
  final String email;
  final String ID;
  @override
  _quizPageState createState() => _quizPageState();
}

class _quizPageState extends State<quizPage> {
  var db = Database();

  String dropDownValue = 'Male';
  String dropDownValue2 = 'Morning Person';
  String dropDownValue3 = '10pm-12pm';
  String dropDownValue4 = 'Introvert';
  String dropDownValue5 = 'Home';
  String dropDownValue6 = 'Yes';
  String dropDownValue7 = 'Neat';
  String dropDownValue8 = 'Below 65 Degrees';
  String dropDownValue9 = 'Yes';
  String dropDownValue10 = 'Soft';

  void submitAnswers(
      gender,
      morningOrNight,
      sleepTime,
      personality,
      studyLocation,
      weekends,
      roomState,
      temperature,
      groceries,
      musicVolume) async {
    var userID = await db.getUserIDFromUsername(widget.user.username);
    var updateGender = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .update({"preferences.gender": gender});
    var updateMorningOrNight = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .update({"preferences.morningornight": morningOrNight});
    var updateSleepTime = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .update({"preferences.sleeptime": sleepTime});
    var updatePersonality = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .update({"preferences.personality": personality});

    var updateStudyLocation = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .update({"preferences.studylocation": studyLocation});
    var updateWeekends = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .update({"preferences.weekends": weekends});
    var updateRoomState = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .update({"preferences.roomstate": roomState});
    var updateTemperature = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .update({"preferences.temperature": temperature});
    var updateGroceries = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .update({"preferences.groceries": groceries});
    var updateMusic = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .update({"preferences.musicpreference": musicVolume});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Container(
                margin: EdgeInsets.only(top: 80),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Text("Gender"),
                    Container(
                        child: DropdownButton<String>(
                      value: dropDownValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Male',
                        'Female',
                        'Non-Binary',
                        'Other',
                        'Prefer Not To Say'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                    Text("How Would You Describe Yourself?"),
                    Container(
                        child: DropdownButton<String>(
                      value: dropDownValue2,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue2 = newValue!;
                        });
                      },
                      items: <String>[
                        'Morning Person',
                        'Night Person',
                        'A True Potato'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                    Text("When Do you Usually Sleep?"),
                    Container(
                        child: DropdownButton<String>(
                      value: dropDownValue3,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue3 = newValue!;
                        });
                      },
                      items: <String>['10pm-12pm', '12am-2am', '2am or later']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                    Text("How Do You Describe Your Personality?"),
                    Container(
                        child: DropdownButton<String>(
                      value: dropDownValue4,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue4 = newValue!;
                        });
                      },
                      items: <String>['Introvert', 'Extrovert']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                    Text("Where Do You Like To Study?"),
                    Container(
                        child: DropdownButton<String>(
                      value: dropDownValue5,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue5 = newValue!;
                        });
                      },
                      items: <String>['Library', 'Home', 'Some Place Random']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                    Text("Do You Like To Go Out On Weekends?"),
                    Container(
                        child: DropdownButton<String>(
                      value: dropDownValue6,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue6 = newValue!;
                        });
                      },
                      items: <String>['Yes', 'No', 'Sometimes']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                    Text("What Is The State Of Your Room Now?"),
                    Container(
                        child: DropdownButton<String>(
                      value: dropDownValue7,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue7 = newValue!;
                        });
                      },
                      items: <String>['Neat', 'Messy']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                    Text("What Temperature Do You Prefer?"),
                    Container(
                        child: DropdownButton<String>(
                      value: dropDownValue8,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue8 = newValue!;
                        });
                      },
                      items: <String>['Below 65 Degrees', 'Above 65 Degrees']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                    Text("Do You Want To Share Groceries?"),
                    Container(
                        child: DropdownButton<String>(
                      value: dropDownValue9,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue9 = newValue!;
                        });
                      },
                      items: <String>['Yes', 'No']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                    Text("What Volume Do You Listen To Music At?"),
                    Container(
                        child: DropdownButton<String>(
                      value: dropDownValue10,
                      onChanged: (String? newValue) {
                        setState(() {
                          dropDownValue10 = newValue!;
                        });
                      },
                      items: <String>['Soft', 'Loud']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                    ElevatedButton(
                      onPressed: () async {
                        submitAnswers(
                            dropDownValue,
                            dropDownValue2,
                            dropDownValue3,
                            dropDownValue4,
                            dropDownValue5,
                            dropDownValue6,
                            dropDownValue7,
                            dropDownValue8,
                            dropDownValue9,
                            dropDownValue10);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TabBarDemo(
                                    email: widget.email,
                                    tabUser: widget.user,
                                    userID: widget.ID,
                                  )),
                        );
                      },
                      child: Text('Submit Quiz Answers'),
                    ),
                  ],
                )))));
  }
}
