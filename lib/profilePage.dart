import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:developer';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:roommatefinder/main.dart';
import 'functions.dart';
import 'package:email_auth/email_auth.dart';

import 'package:flutter/material.dart';
import 'userClass.dart';
import 'package:image_picker/image_picker.dart';

// void main() {
//   runApp(const MaterialApp(
//     title: 'Navigation Basics',
//     home: profilePage(),
//   ));
// }

class profilePage extends StatelessWidget {
  const profilePage({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Flexible(
          child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 0.6,
              child: InkResponse(
                child: Container(
                  color: Colors.green,
                ),
              ))),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(user.username,
            textAlign: TextAlign.left, textScaleFactor: 4.0),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(user.name, textAlign: TextAlign.left, textScaleFactor: 2.0),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child:
            Text(user.email, textAlign: TextAlign.left, textScaleFactor: 2.0),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
            child: const Text('Logout'),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
              );
            }),
      ),
    ]));
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
