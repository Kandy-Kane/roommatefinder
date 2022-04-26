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
import 'messageDetailPage.dart';

class messagesPage extends StatefulWidget {
  const messagesPage({Key? key, required this.user, required this.userID})
      : super(key: key);

  final User user;
  final String userID;

  @override
  _messagesPageState createState() => _messagesPageState();
}

class _messagesPageState extends State<messagesPage> {
  var db = Database();

  final myController = TextEditingController();
  var collection = FirebaseFirestore.instance.collection('USERS');

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> snaps = FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.userID)
        .collection('allMessages')
        .snapshots();

    var messageCollection = FirebaseFirestore.instance
        .collection('USERS')
        .doc(widget.userID)
        .collection('allMessages');

    //allMyMessages.add(userMessage);

    return Scaffold(

        // appBar: AppBar(
        //   title: Text("Notes"),
        //   centerTitle: true,
        // ),
        body: Column(
      children: [
        // SizedBox(
        //     child: TextFormField(
        //   controller: myController,
        //   onChanged: (value) async {
        //     setState(() {
        //       if (value == "") {
        //         snaps = FirebaseFirestore.instance
        //             .collection('USERS')
        //             .doc(widget.userID)
        //             .collection('allMessages')
        //             .snapshots();
        //       } else {
        //         snaps = collection
        //             .where('name', isGreaterThanOrEqualTo: value)
        //             .where('name', isLessThan: value + 'z')
        //             .snapshots();
        //         // snaps2 = collection
        //         //     .where('email', isGreaterThanOrEqualTo: value)
        //         //     .where('email', isLessThan: value + 'z')
        //         //     .snapshots();
        //       }
        //     });
        //   },
        //   decoration: const InputDecoration(
        //     border: UnderlineInputBorder(),
        //     labelText: 'Search Using Name',
        //   ),
        // )),
        // SizedBox(
        //     child: ElevatedButton(
        //   onPressed: () async {
        //     var userID = await db.findUserForMessage(
        //         widget.user.username, widget.user.name);
        //     var user2 =
        //         await db.findUserForMessage('DangitBobby', 'Bobby Hill');
        //     var userMessage = new UserTexts(userID: userID, messengerID: user2);

        //     var userMessage2 =
        //         new UserTexts(userID: user2, messengerID: userID);

        //     await db.addMessage(userID, user2);
        //   },
        //   child: Text("SEND MESSAGE SAMPLE"),
        // )),
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
                    return Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ListTile(
                        leading: Container(
                            decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.black45)),
                            child: Image.asset(
                                'lib/assets/images/schoolLogo.png')),
                        title: Row(
                          children: [
                            Text(doc['username']),
                            Spacer(),
                            Text(
                              doc['newMessageIndicator'],
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),

                        // subtitle: Container(
                        //   // decoration: BoxDecoration(color: Colors.amber),
                        //   child: Text(
                        //     doc['newMessageIndicator'],
                        //     style: TextStyle(
                        //         color: Color.fromARGB(255, 255, 22, 5)),
                        //   ),
                        // ),
                        onLongPress: () async {
                          // await db.deleteMessage(widget.user.username, doc.id);
                          _showPopupMenu(doc.id);
                        },
                        //trailing: Icon(Icons.more_vert),
                        onTap: () async {
                          var updateMessageIndicator = await messageCollection
                              .doc(doc.id)
                              .update({'newMessageIndicator': ""});
                          //var db = Database();
                          var user2ID =
                              await db.getUserIDFromUsername(doc['username']);
                          var message2Ref = await db.findSelectedMessage(
                              user2ID, widget.user.username);
                          //var selectedUser = await db.queryMessage(doc.id, doc['userID']);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => messageDetailPage(
                                    messageID: doc.id,
                                    userID: widget.userID,
                                    user: widget.user,
                                    user2ID: user2ID,
                                    message2ID: message2Ref,
                                    userUsername: doc['username'],
                                  )));
                        },
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
      ],
    ));
  }

  void _showPopupMenu(docID) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 100, 100),
      color: Colors.amber,
      items: [
        PopupMenuItem<String>(
            child: Container(
              child: Icon(Icons.delete_forever),
            ),
            value: 'deleteMessage',
            onTap: () async {
              await db.deleteMessage(widget.user.username, docID);
            }),
        PopupMenuItem<String>(
          child: Container(
            child: Icon(Icons.arrow_back),
          ),
          value: 'cancel',
          onTap: () {
            null;
          },
        ),
      ],
      elevation: 8.0,
    );
  }
}
