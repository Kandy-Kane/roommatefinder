import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongo_dart/mongo_dart.dart';

class User {
  final String name;
  final String username;
  final String email;

  const User({
    required this.name,
    required this.username,
    required this.email,
  });
}
