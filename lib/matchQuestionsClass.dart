import 'package:flutter/material.dart';
//import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/tabs.dart';
import 'package:roommatefinder/userClass.dart';
import 'package:roommatefinder/user_Firebase.dart';
import 'reference.dart';

/*
  gender
  morning or night person
  personality type
  study habits
  weekend habits
  how clean are you
  what temperature for the room
  food types
  music volume
 */

class MatchQuestions {
  //final String ID;
  final String gender;
  final String personalityType;
  final String studyHabits;
  final String weekendHabits;
  final String cleanliness;
  final String preferedTemperature;
  final String foodTypes;
  final String musicVolume;

  const MatchQuestions({
    //required this.ID,
    required this.gender,
    required this.personalityType,
    required this.studyHabits,
    required this.weekendHabits,
    required this.cleanliness,
    required this.preferedTemperature,
    required this.foodTypes,
    required this.musicVolume,
  });
}
