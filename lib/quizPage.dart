import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/emailAuthClass.dart';
import 'package:roommatefinder/tabs.dart';
import 'package:roommatefinder/verificationPage.dart';
import 'reference.dart';
import 'mongodbAttempt/mongouserClass.dart';
import 'mongodbAttempt/database.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'user_Firebase.dart';

// class quizPage extends StatelessWidget {
//   const quizPage({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // Try running your application with "flutter run". You'll see the
//           // application has a blue toolbar. Then, without quitting the app, try
//           // changing the primarySwatch below to Colors.green and then invoke
//           // "hot reload" (press "r" in the console where you ran "flutter run",
//           // or simply save your changes to "hot reload" in a Flutter IDE).
//           // Notice that the counter didn't reset back to zero; the application
//           // is not restarted.
//           primarySwatch: Colors.red),
//       home: const quizPage(),
//     );
//   }
// }

class quizPage extends StatefulWidget {
  const quizPage({Key? key}) : super(key: key);

  @override
  State<quizPage> createState() => _quizPageState();
}

class _quizPageState extends State<quizPage> {
  static var myAuth;
  int _counter = 0;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: myController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Full Name',
            ),
          ),
          TextFormField(
            controller: myController2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            //controller: myController,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Username',
            ),
          ),
          TextFormField(
            controller: myController3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } else if (!value.contains("manhattan.edu")) {
                return 'Please use your Manhattan College Email';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Your Email',
            ),
          ),

          TextFormField(
            controller: myController4,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Create A Password',
            ),
          ),

          TextFormField(
            controller: myController5,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Re-Enter Your Password';
              } else if (value != myController4.text) {
                return 'Passwords Do Not Match';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Re-Enter Password',
            ),
          ),

          //SEND BUTTON
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                // Respond to button press
                //sendOTP();
                myAuth = emailAuthClass(myController3.text);
                int result = await myAuth.sendOTP();
                log(result.toString());
                if (result == 1) {
                  log(myController3.text);
                  _showMyDialog();
                } else {}
                log(myController3.text);
              }
            },
            child: Text('SEND Verification Code'),
          ),

          // ElevatedButton(
          //   onPressed: () {
          //     // Respond to button press
          //     verifyOTP();
          //     log(myController.text);
          //   },
          //   child: Text('VERIFY OTP'),
          // ),

          // ElevatedButton(
          //   onPressed: () {
          //     var db = Database();
          //     db.addUser(myController.text, myController2.text,
          //         myController3.text, myController4.text);
          //     // Respond to button press
          //     Navigator.pushReplacement(
          //       context,
          //       MaterialPageRoute(builder: (context) => const TabBarDemo()),
          //     );
          //   },
          //   child: Text('DEVELOPING'),
          // )
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('EMAIL SENT'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('VERIFICATION EMAIL SENT'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => otpVerification(
                          emailAuthFinal: myAuth,
                          name: myController.text,
                          username: myController2.text,
                          email: myController3.text,
                          password: myController4.text)),
                );
              },
            ),
          ],
        );
      },
    );
  }
}