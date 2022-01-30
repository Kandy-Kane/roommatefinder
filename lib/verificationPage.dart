import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/emailAuthClass.dart';
import 'package:roommatefinder/tabs.dart';
import 'reference.dart';
import 'mongodbAttempt/userClass.dart';
import 'mongodbAttempt/database.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'user_Firebase.dart';

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

  // void verifyOTP() async {
  //   var res = emailAuth.validateOtp(
  //       recipientMail: myController.text, userOtp: myController.text);
  //   if (res) {
  //     log("OTP VERFIED");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const TabBarDemo()),
  //     );
  //     myController.clear();
  //   } else {
  //     log("OTP INVALID");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: myController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'ENTER OTP',
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
                  // Respond to button press
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const TabBarDemo()),
                  );
                } else {
                  log("PROBLEM VERIFYING OTP IN VERIFICATiON PAGE");
                }
              },
              child: Text('Verify OTP'),
            )
          ],
        ),
      ),
    );
  }
}
