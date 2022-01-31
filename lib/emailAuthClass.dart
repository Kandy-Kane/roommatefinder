import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/tabs.dart';
import 'package:roommatefinder/verificationPage.dart';
import 'reference.dart';
import 'mongodbAttempt/mongouserClass.dart';
import 'mongodbAttempt/database.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'user_Firebase.dart';

class emailAuthClass {
  final String email;
  //final String otp;

  emailAuthClass(this.email);

  var emailAuth = EmailAuth(sessionName: "Roommate Finder Session");

  Future<int> sendOTP() async {
    bool result = await emailAuth.sendOtp(recipientMail: email, otpLength: 5);
    if (result) {
      log("OTP SENT!");
      return 1;
      //_showMyDialog();
    } else {
      log('problem did not send');
      return 0;
    }
  }

  Future<int> verifyOTP(String Otp) async {
    var res = emailAuth.validateOtp(recipientMail: email, userOtp: Otp);
    if (res) {
      log("OTP VERFIED");
      return 1;
    } else {
      log("OTP INVALID");
      return 0;
    }
  }
}
