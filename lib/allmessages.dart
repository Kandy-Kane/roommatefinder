import 'package:flutter/material.dart';
import 'package:roommatefinder/singleTextClass.dart';
import 'userClass.dart';
// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'userTextsClass.dart';

class AllMessages {
  final List<dynamic> allMessages;

  const AllMessages({required this.allMessages});
}
