import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:developer';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:roommatefinder/main.dart';
import 'package:roommatefinder/messageDetailPage.dart';
import 'package:roommatefinder/messagesPage.dart';
import 'functions.dart';
import 'package:email_auth/email_auth.dart';

import 'package:flutter/material.dart';
import 'userClass.dart';
import 'user_Firebase.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:developer';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:roommatefinder/main.dart';
import 'package:roommatefinder/user_Firebase.dart';
import 'functions.dart';
import 'package:email_auth/email_auth.dart';

import 'package:flutter/material.dart';
import 'userClass.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cached_network_image/cached_network_image.dart';

class selectedProfilePage extends StatefulWidget {
  const selectedProfilePage(
      {Key? key, required this.user, required this.selectedUser})
      : super(key: key);
  final User user;
  final User selectedUser;

  @override
  State<selectedProfilePage> createState() => _selectedProfilePageState();
}

class _selectedProfilePageState extends State<selectedProfilePage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  String errorMsg = '';

  var collection = FirebaseFirestore.instance.collection('USERS');
  bool _isEditingText = false;
  final TextEditingController _editingController = TextEditingController();
  late String initialText;
  var db = Database();
  var profilePic;

  @override
  void initState() {
    super.initState();
    _editingController.text = widget.user.bio;
    initialText = widget.user.bio;
    // var profilePic = downloadURLExample();
    getProfilePicInfo();
  }

  Future<void> getProfilePicInfo() async {
    Uint8List? imageBytes = await storage
        .ref()
        .child(widget.selectedUser.email + ": Profile Pic")
        .getData(10000000);
    // log(imageBytes.toString());
    setState(() {
      profilePic = imageBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    var img = profilePic != null
        ? Image.memory(
            profilePic,
            fit: BoxFit.fitHeight,
          )
        : Text(errorMsg != null ? errorMsg : "Loading...");
    var db = Database();
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 4, 43, 5),
        body: Column(children: [
          Flexible(
              child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Container(
                    child: img,
                  ))),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 10, 6, 2),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.selectedUser.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 238, 194, 49),
                        fontSize: 27.0,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ]),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 6, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.selectedUser.username,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About me:",
                    style: TextStyle(
                      color: Color.fromARGB(255, 62, 192, 243),
                      fontStyle: FontStyle.normal,
                      fontSize: 21.0,
                    ),
                  ),
                  Text(
                    widget.selectedUser.bio,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 1, 10, 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.selectedUser.email,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Color.fromARGB(255, 238, 194, 49),
                      fontSize: 16.0,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
                child: Text('Message'),
                onPressed: () async {
                  log("START FINDING MESSAGE PROCESS");
                  var user1 = await db.findUserForMessage(
                      widget.user.username, widget.user.name);
                  log("\n\n\n\n====================================================================================================\nUSER1: " +
                      widget.user.username);
                  log("USER2: " + widget.selectedUser.username);
                  var user2 = await db.findUserForMessage(
                      widget.selectedUser.username, widget.selectedUser.name);
                  var UID =
                      await db.getUserIDFromUsername(widget.user.username);
                  var user2ID = await db
                      .getUserIDFromUsername(widget.selectedUser.username);
                  var messageID = await db.findSelectedMessage(
                      UID, widget.selectedUser.username);
                  log("\n\n\n\n=======================================================================================\nTest MESSAGE FOUND: " +
                      messageID.toString());

                  if (messageID == '') {
                    var sendMessage = await db.addMessage(user1, user2);
                    var sendMessage2 = await db.addMessage(user2, user1);
                    log('MESSAGE REFERENCE 1: ' + sendMessage[0].toString());
                    log('MESSAGE REFERENCE 2: ' + sendMessage[1].toString());
                    // var newMessageID =
                    //     await db.findSelectedMessage(UID, user.username);
                    // log("MESSAGE 1 ID: " + newMessageID);

                    // var newMessage2ID = await db.findSelectedMessage(
                    //     user2ID, selectedUser.username);
                    // log("MESSAGE 2 ID: " + newMessage2ID);
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => messageDetailPage(
                              messageID: sendMessage[1],
                              userID: UID,
                              user: widget.user,
                              message2ID: sendMessage2[1],
                              user2ID: user2ID,
                              userUsername: widget.selectedUser.username)),
                    );
                  } else {
                    var messageID = await db.findSelectedMessage(
                        UID, widget.selectedUser.username);

                    log("MESSAGE FOUND 1 ID Not New: " + messageID);

                    var message2ID = await db.findSelectedMessage(
                        user2ID, widget.user.username);
                    log("MESSAGE FOUND 2 ID Not New: " + message2ID);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => messageDetailPage(
                          messageID: messageID,
                          userID: UID,
                          user: widget.user,
                          message2ID: message2ID,
                          user2ID: user2ID,
                          userUsername: widget.selectedUser.username),
                    ));
                  }

                  // var userId = await sendMessage.elementAt(0);
                  // var messageId = await sendMessage.elementAt(1);
                  // log("USER ID:" + userId);
                  // log("MESSAGE ID:" + messageId);
                }),
          ),
        ]));
  }
}
