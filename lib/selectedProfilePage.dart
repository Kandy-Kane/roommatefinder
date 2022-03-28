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

class selectedProfilePage extends StatelessWidget {
  const selectedProfilePage(
      {Key? key, required this.user, required this.selectedUser})
      : super(key: key);

  final User user;
  final User selectedUser;
  @override
  Widget build(BuildContext context) {
    var db = Database();
    return Scaffold(
        body: Column(children: [
      Flexible(
          child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 0.6,
              child: Container(
                color: Colors.green,
              ))),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(selectedUser.username,
            textAlign: TextAlign.left, textScaleFactor: 4.0),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(selectedUser.name,
            textAlign: TextAlign.left, textScaleFactor: 2.0),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(selectedUser.email,
            textAlign: TextAlign.left, textScaleFactor: 2.0),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
            child: Text('Message'),
            onPressed: () async {
              log("START FINDING MESSAGE PROCESS");
              var user1 = await db.findUserForMessage(user.username, user.name);
              log("\n\n\n\n====================================================================================================\nUSER1: " +
                  user.username);
              log("USER2: " + selectedUser.username);
              var user2 = await db.findUserForMessage(
                  selectedUser.username, selectedUser.name);
              var UID = await db.getUserIDFromUsername(user.username);
              var user2ID =
                  await db.getUserIDFromUsername(selectedUser.username);
              var messageID =
                  await db.findSelectedMessage(UID, selectedUser.username);
              log("\n\n\n\n=======================================================================================\nTest MESSAGE FOUND: " +
                  messageID.toString());

              if (messageID == '') {
                var sendMessage = await db.addMessage(user1, user2);
                var sendMessage2 = await db.addMessage(user2, user1);
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
                          messageID: sendMessage[0],
                          userID: UID,
                          user: user,
                          message2ID: sendMessage[1],
                          user2ID: user2ID,
                          userUsername: selectedUser.username)),
                );
              } else {
                var messageID =
                    await db.findSelectedMessage(UID, selectedUser.username);

                log("MESSAGE FOUND 1 ID Not New: " + messageID);

                var message2ID =
                    await db.findSelectedMessage(user2ID, user.username);
                log("MESSAGE FOUND 2 ID Not New: " + message2ID);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => messageDetailPage(
                      messageID: messageID,
                      userID: UID,
                      user: user,
                      message2ID: message2ID,
                      user2ID: user2ID,
                      userUsername: selectedUser.username),
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
