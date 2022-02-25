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
  const quizPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _quizPageState createState() => _quizPageState();
}

class _quizPageState extends State<quizPage> {
  var db = Database();

  String dropDownValue = 'Male';
  String dropDownValue2 = 'Morning';
  String dropDownValue3 = 'CS';

  void submitAnswers(age, gender, major) async {
    var userID = await db.getUserIDFromUsername(widget.user.username);
    var userPreferences = await FirebaseFirestore.instance
        .collection('USERS')
        .doc(userID)
        .collection('preferences');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
          items: <String>['Male', 'Female', 'Other', 'Prefer Not To Say']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )),
        Text("Age"),
        Container(
            child: DropdownButton<String>(
          value: dropDownValue2,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue2 = newValue!;
            });
          },
          items: <String>['Morning', 'Night', 'All Day', 'Forever Tired']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )),
        Text("Major"),
        Container(
            child: DropdownButton<String>(
          value: dropDownValue3,
          onChanged: (String? newValue) {
            setState(() {
              dropDownValue3 = newValue!;
            });
          },
          items: <String>['CS', 'Business', 'Mathamatics', 'English']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )),
        // Text("Personality Type"),
        // Container(
        //     child: DropdownButton<String>(
        //   value: dropDownValue2,
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       dropDownValue2 = newValue!;
        //     });
        //   },
        //   items: <String>['Introvert', 'Extrovert', 'Unsure', 'Panda']
        //       .map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        // )),
        // Text("Major"),
        // Container(
        //     child: DropdownButton<String>(
        //   value: dropDownValue2,
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       dropDownValue2 = newValue!;
        //     });
        //   },
        //   items: <String>['Computer Science', 'Business', 'Communications', 'Mathamatics']
        //       .map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        // )),
        // Text("Morning Or Night Person"),
        // Container(
        //     child: DropdownButton<String>(
        //   value: dropDownValue2,
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       dropDownValue2 = newValue!;
        //     });
        //   },
        //   items: <String>['Morning', 'Night', 'All Day', 'Forever Tired']
        //       .map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        // )),
        // Text("Morning Or Night Person"),
        // Container(
        //     child: DropdownButton<String>(
        //   value: dropDownValue2,
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       dropDownValue2 = newValue!;
        //     });
        //   },
        //   items: <String>['Morning', 'Night', 'All Day', 'Forever Tired']
        //       .map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        // )),
        // Text("Morning Or Night Person"),
        // Container(
        //     child: DropdownButton<String>(
        //   value: dropDownValue2,
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       dropDownValue2 = newValue!;
        //     });
        //   },
        //   items: <String>['Morning', 'Night', 'All Day', 'Forever Tired']
        //       .map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        // )),
        // Text("Morning Or Night Person"),
        // Container(
        //     child: DropdownButton<String>(
        //   value: dropDownValue2,
        //   onChanged: (String? newValue) {
        //     setState(() {
        //       dropDownValue2 = newValue!;
        //     });
        //   },
        //   items: <String>['Morning', 'Night', 'All Day', 'Forever Tired']
        //       .map<DropdownMenuItem<String>>((String value) {
        //     return DropdownMenuItem<String>(
        //       value: value,
        //       child: Text(value),
        //     );
        //   }).toList(),
        // )),
        // TextButton(onPressed: submitAnswers, child: const Text('Submit'))
      ],
    );
  }
}
