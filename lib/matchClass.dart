import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:roommatefinder/allmessages.dart';
import 'package:roommatefinder/singleTextClass.dart';
import 'package:roommatefinder/userTextsClass.dart';

class matchUser {
  //final String ID;
  String name;
  int points;

  matchUser(
      {
      //required this.ID,
      required this.name,
      required this.points});
}
