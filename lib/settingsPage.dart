import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:http/http.dart';
import 'dart:developer';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:roommatefinder/main.dart';
import 'package:roommatefinder/profilePage.dart';
import 'package:roommatefinder/quizPage.dart';
import 'package:roommatefinder/register.dart';
import 'package:roommatefinder/user_Firebase.dart';
import 'functions.dart';
import 'package:email_auth/email_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'userClass.dart';
import 'selectedProfilePage.dart';
import 'package:roommatefinder/updatePassword.dart';

class settingsPage extends StatefulWidget {
  settingsPage({Key? key, required this.user}) : super(key: key);

  User user;

  @override
  _settingsPageState createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  var collection = FirebaseFirestore.instance.collection('USERS');
  var db = Database();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  void deleteAccount() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Your Account'),
          content: SingleChildScrollView(
              child: Center(
                  child: Column(
            children: [
              Text(
                  "Are you sure you'd like to permanently delete your account.")
            ],
          ))),
          actions: [
            TextButton(
              child: Text('No'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () async {
                var UID = await db.getUserIDFromUsername(widget.user.username);
                collection
                    .doc(UID)
                    .delete()
                    .then((value) => print("User Deleted"))
                    .catchError(
                        (error) => print("Failed to delete user: $error"));
                log('USER BEING DELETED: ' + UID);
                await storage
                    .ref()
                    .child(widget.user.email + ":Profile Pic")
                    .delete();
                sendUserBack();
                // collection.doc(UID).delete();
                // Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void sendUserBack() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thank You'),
          content: SingleChildScrollView(
              child: Center(
                  child: Column(
            children: [Text("Your account has been successfuly deleted.")],
          ))),
          actions: [
            TextButton(
              child: Text('Okay'),
              onPressed: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    // Material page route makes it
                    // slide from the bottom to the top
                    //
                    // If you want it to slide from the right to the left, use
                    // `CupertinoPageRoute()` from the cupertino library.
                    //
                    // If you want something else, then create your own route
                    // https://flutter.dev/docs/cookbook/animation/page-route-animation
                    builder: (context) {
                      return MainPage();
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 79, 3),
          title: Text(
            'Account Settings',
            style: TextStyle(fontSize: 25),
          ),
          actions: []),
      body: Column(
        children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: () {
              deleteAccount();
            },
            child: Text(
              'Delete Account',
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 0, 204, 255))),
            onPressed: () async {
              var userID = await db.getUserIDFromUsername(widget.user.username);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return quizPage(
                        user: widget.user,
                        email: widget.user.email,
                        ID: userID);
                  },
                ),
              );
            },
            child: Text(
              'Update Quiz Answers',
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 0, 200, 255))),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return updatePassword(
                      user: widget.user,
                    );
                  },
                ),
              );
            },
            child: Text(
              'Change Password',
            ),
          ),
        ],
      ),
    );
  }
}
