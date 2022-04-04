import 'package:flutter/material.dart';
import 'package:roommatefinder/reference.dart';
import 'package:roommatefinder/register.dart';
import 'package:roommatefinder/signIn.dart';
// import 'package:mongo_dart/mongo_dart.dart';
import 'mongodbAttempt/constants.dart';
import 'mongodbAttempt/database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Splash extends StatelessWidget {
  const ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Container(
          child: Text(
            'Splash Screen',
            style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}