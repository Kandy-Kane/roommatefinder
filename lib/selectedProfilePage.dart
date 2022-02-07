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
              var user1 = await db.findUserForMessage(user.username, user.name);
              var user2 = await db.findUserForMessage(
                  selectedUser.username, selectedUser.name);
              var sendMessage = await db.addMessage(user1, user2);
              var sendMessage2 = await db.addMessage(user2, user1);
              // var userId = await sendMessage.elementAt(0);
              // var messageId = await sendMessage.elementAt(1);
              // log("USER ID:" + userId);
              // log("MESSAGE ID:" + messageId);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        messagesPage(user: user, userID: user1)),
              );
            }),
      ),
      // Container(
      //   alignment: Alignment.centerLeft,
      //   child: ElevatedButton(
      //       child: const Text('Logout'),
      //       onPressed: () {
      //         Navigator.pushReplacement(
      //           context,
      //           MaterialPageRoute(builder: (context) => const MainPage()),
      //         );
      //       }),
      // ),
    ]));
  }
}

// class SecondRoute extends StatelessWidget {
//   const SecondRoute({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Second Route'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }
