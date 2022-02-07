import 'package:flutter/material.dart';
import 'userClass.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongo_dart/mongo_dart.dart';

class SingleText {
  final String text;
  final String sendBy;
  final DateTime dateTime;

  const SingleText({
    required this.sendBy,
    required this.text,
    required this.dateTime,
  });
}
