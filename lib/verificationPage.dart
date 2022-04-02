import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/allmessages.dart';
import 'package:roommatefinder/emailAuthClass.dart';
import 'package:roommatefinder/quizPage.dart';
import 'package:roommatefinder/tabs.dart';
import 'reference.dart';
import 'mongodbAttempt/mongouserClass.dart';
import 'mongodbAttempt/database.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'user_Firebase.dart';
import 'userClass.dart';
import 'userTextsClass.dart';

class otpVerification extends StatefulWidget {
  const otpVerification(
      {Key? key,
      required this.emailAuthFinal,
      required this.name,
      required,
      required this.username,
      required this.email,
      required this.password})
      : super(key: key);

  final emailAuthClass emailAuthFinal;
  final String name;
  final String username;
  final String email;
  final String password;
  @override
  _otpVerificationState createState() => _otpVerificationState();
}

class _otpVerificationState extends State<otpVerification> {
  final myController = TextEditingController();
  List<UserTexts> myMessages = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: TextFormField(
                controller: myController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'ENTER OTP',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                int result =
                    await widget.emailAuthFinal.verifyOTP(myController.text);
                if (result == 1) {
                  var db = Database();
                  db.addUser(widget.name, widget.username, widget.email,
                      widget.password);
                  var myUser = User(
                      name: widget.name,
                      username: widget.username,
                      email: widget.email,
                      bio: 'Enter something for your bio');
                  var userID =
                      await db.findUserForMessage(myUser.username, myUser.name);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => quizPage(
                              email: widget.email,
                              user: myUser,
                              ID: userID,
                            )),
                  );
                } else {
                  log("PROBLEM VERIFYING OTP IN VERIFICATiON PAGE");
                  incorrectVerificationNUmber();
                }
              },
              child: Text('Verify OTP'),
            )
          ],
        ),
      ),
    );
  }

  void incorrectVerificationNUmber() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Verification Number Incorrect'),
          content: SingleChildScrollView(
              child:
                  Center(child: Text('Your verification number is incorrect'))),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
