import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:developer';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:roommatefinder/allmessages.dart';
import 'package:roommatefinder/main.dart';
import 'package:roommatefinder/singleTextClass.dart';
import 'package:roommatefinder/userTextsClass.dart';
import 'package:roommatefinder/profilePage.dart';
import 'package:roommatefinder/user_Firebase.dart';
import 'functions.dart';
import 'package:email_auth/email_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'userClass.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class messageDetailPage extends StatefulWidget {
  const messageDetailPage(
      {Key? key,
      required this.messageID,
      required this.userID,
      required this.user,
      required this.message2ID,
      required this.user2ID,
      required this.userUsername})
      : super(key: key);

  //final User user;
  final User user;
  final String userID;
  final String messageID;

  final String user2ID;
  final String message2ID;
  final String userUsername;
  @override
  _messageDetailPageState createState() => _messageDetailPageState();
}

class _messageDetailPageState extends State<messageDetailPage> {
  var db = Database();
  final myController = TextEditingController();
  var collection = FirebaseFirestore.instance.collection('USERS');

  Color getDynamicColor(String username) {
    if (username == widget.user.username) {
      return Color.fromARGB(255, 194, 255, 124);
    } else {
      return Color.fromARGB(255, 68, 218, 245);
    }
  }

  EdgeInsets getDynamicMargin(String username) {
    if (username == widget.user.username) {
      log(widget.user.username);
      return EdgeInsets.only(left: 250.0, top: 16, bottom: 16, right: 10);
    } else {
      return EdgeInsets.only(right: 250.0, top: 16, bottom: 16, left: 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    var usernameHolder = '';
    Stream<QuerySnapshot> snaps = FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.userID)
        .collection('allMessages')
        .doc(widget.messageID)
        .collection('allTexts')
        .orderBy('dateTime')
        .snapshots();

    var messageReference = FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.userID)
        .collection('allMessages')
        .doc(widget.messageID)
        .collection('allTexts');

    var messageReference2 = FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.user2ID)
        .collection('allMessages')
        .doc(widget.message2ID)
        .collection('allTexts');

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.userUsername),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Flexible(
                child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder<QuerySnapshot>(
                stream: snaps,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView(
                      children: (snapshot.data!).docs.map((doc) {
                        log(doc.toString());
                        return Container(
                          //width: MediaQuery.of(context).size.width / 2,
                          decoration: BoxDecoration(
                              color: getDynamicColor(doc['sentBy']),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.blueAccent)),
                          //margin: EdgeInsets.all(16.0),
                          margin: getDynamicMargin(doc['sentBy']),
                          //widthFactor: 0.5,
                          child: ListTile(
                            title: Text(doc['messageBody']),
                            subtitle: Text((doc['dateTime'] as Timestamp)
                                .toDate()
                                .toString()),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            )
                //)
                ),
            SizedBox(
              child: TextFormField(
                controller: myController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } 
                  return null;
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 3, color: Colors.blue),
                  ),
                  labelText: 'Enter your message',
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.green),
                  borderRadius: BorderRadius.circular(15),
                )
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                messageReference.add({
                  'messageBody': myController.text,
                  'dateTime': DateTime.now(),
                  'sentBy': widget.user.username
                });
                messageReference2.add({
                  'messageBody': myController.text,
                  'dateTime': DateTime.now(),
                  'sentBy': widget.user.username
                });
                myController.clear();
              },
              child: Text('SEND'),
            )
          ],
        ));
  }
}
