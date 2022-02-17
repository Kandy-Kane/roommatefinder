import 'dart:developer';

import 'package:flutter/material.dart';
//import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/tabs.dart';
import 'package:roommatefinder/userClass.dart';
import 'package:roommatefinder/user_Firebase.dart';
import 'reference.dart';

class quizPage extends StatefulWidget {
  const quizPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _quizPageState createState() => _quizPageState();
}

class _quizPageState extends State<quizPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Gender"),
        Container(
            child: DropdownButton<String>(
          items: <String>['Male', 'Female', 'Other', 'Prefer Not To Say']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        )),
        Text("Morning Or Night Person"),
        Container(
            child: DropdownButton<String>(
          items: <String>[
            'Morning Person',
            'Night Person',
            'Both!',
            'Always Tired'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        )),
        Text("Personality Type"),
        Container(
            child: DropdownButton<String>(
          items: <String>['Introvert', 'Extrovert'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        )),
        Text("Study Habits"),
        Container(
            child: DropdownButton<String>(
          items: <String>[
            'Study At Home',
            'Study at the Library',
            'Study at Starbucks',
            'Study Somewhere Random'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        )),
        Text("Weekend Habits"),
        Container(
            child: DropdownButton<String>(
          items: <String>['Go Out', 'Stay In', 'Study Like a Lame']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        )),
        Text("How Clean Are You"),
        Container(
            child: DropdownButton<String>(
          items: <String>[
            'Extremely Clean',
            'Normal Amount of Clean',
            'On the Messier Side',
            'Straight Slob'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        )),
        Text("Preferred Room Temperature"),
        Container(
            child: DropdownButton<String>(
          items: <String>['Cold', 'Hot', 'Cold At Night', 'Warm At Night']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        )),
        Text("Food Choices"),
        Container(
            child: DropdownButton<String>(
          items: <String>['Diet Food', 'Junk Food', 'Leftovers', 'Semi-Healthy']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        )),
        Text("Music Volume"),
        Container(
            child: DropdownButton<String>(
          items: <String>['Loud', 'Quiet', 'Prefer Headphones']
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (_) {},
        )),
      ],
    );
  }
}
