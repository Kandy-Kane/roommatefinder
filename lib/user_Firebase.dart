// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:roommatefinder/allmessages.dart';
import 'userClass.dart';
import 'singleTextClass.dart';
import 'userTextsClass.dart';

class Database {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('USERS');

  Future<void> addUser(
      String name, String username, String email, String password) async {
    var userDocID;
    var messageid;
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'name': name, // John Doe
          'username': username, // Stokes and Sons
          'email': email,
          'password': password, // 42
        })
        .then((value) async {
          userDocID = value.id;
          var messageRef = await users
              .doc(userDocID)
              .collection('allMessages')
              .add({
                'messengerID': 'ROOMMATE FINDER',
                'userID': userDocID,
                'username': 'ROOMMATE FINDER'
              })
              .then((value) => messageid = value.id)
              .then((value) => log('MESSAGE REFERENCE: ' + messageid))
              .then((value) {
                var textref = users
                    .doc(userDocID)
                    .collection('allMessages')
                    .doc(messageid)
                    .collection('allTexts')
                    .add({
                  'messageBody': 'WELCOME',
                  'dateTime': DateTime.now()
                }).then((value) => log("TEXT REFERNCE: " + value.id));
              })
              .catchError((error) => log("Failed to send Message: $error"));
        })
        .then((value) => log("User Added"))
        .catchError((error) => log("Failed to add user: $error"));
  }

  Future<bool> findUser(String email, String password) async {
    bool foundEmail = false;
    bool matched = false;
    //query the whole collection search by email
    var user = await users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print(doc["email"]);
        if (doc['email'] == email) {
          print("USER FOUND!!!");
          print(doc.data());
          foundEmail = true;
          if (doc['password'] == password) {
            print("PASSWORD MATCH");
            matched = true;
          }
        }
      });
    });
    return matched;
  }

  Future<String> findUserForMessage(String username, String name) async {
    var uid;
    String userNameTemp;
    String nameTemp;
    String email;
    List<dynamic> allMessages;
    bool foundEmail = false;
    bool matched = false;
    var myUser;
    //query the whole collection search by email
    var user = await users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print(doc["email"]);
        if (doc['username'] == username) {
          log("\n\nUSER FOUND FOR MESSAGE!!!\n\n");
          log(doc.data().toString());
          foundEmail = true;
          if (doc['name'] == name) {
            log("NAME MATCH");
            log("USERID: " + doc.id);
            matched = true;
            userNameTemp = doc['username'];
            nameTemp = doc['name'];
            email = doc['email'];
            uid = doc.id;
            //myUser = User(name: nameTemp, username: userNameTemp, email: email);
          }
        }
      });
    });
    return uid;
  }

  Future<String> getUserIDFromUsername(String username) async {
    var uid;
    String userNameTemp;
    String nameTemp;
    String email;
    List<dynamic> allMessages;
    bool foundEmail = false;
    bool matched = false;
    var myUser;
    //query the whole collection search by email
    var user = await users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print(doc["email"]);
        if (doc['username'] == username) {
          log("\n\nUSER FOUND FOR MESSAGE!!!\n\n");
          log(doc.data().toString());
          foundEmail = true;
          uid = doc.id;
        }
      });
    });
    return uid;
  }

  Future<String> findSelectedMessage(String uid, String username) async {
    String messageRef = '';
    bool foundEmail = false;
    bool matched = false;
    //query the whole collection search by email
    var user = await users
        .doc(uid)
        .collection('allMessages')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print(doc["email"]);
        if (doc['username'] == username) {
          log("\n\nUSER FOUND FOR MESSAGE!!!\n\n");
          log(doc.data().toString());
          foundEmail = true;
          messageRef = doc.id;
        }
      });
    });
    return messageRef;
  }

  Future<String> getUsersUsername(String uid) async {
    String userName = '';
    var user = await users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print(doc["email"]);
        if (doc.id == uid) {
          log("\n\nUSER FOUND GETTING USERID!!!\n\n");
          log(doc.data().toString());
          userName = doc['username'];
          //myUser = User(name: nameTemp, username: userNameTemp, email: email);
        } else {}
      });
    });
    return userName;
  }

  Future<List<String>> addMessage(String user1, String user2) async {
    var messageArray = <String>[];
    var message1id = '';
    var message2id = '';
    var hellotext = 'hello';

    var user1again = await users.doc(user1);
    var user2again = await users.doc(user2);

    var user1ID = await getUsersUsername(user1again.id);

    messageArray.add(user1ID);

    var user2ID = await getUsersUsername(user2again.id);
    log('USERNAME: ' + user2ID);

    bool messageFound = false;
    var docReference;

    var attempt = await user1again
        .collection('allMessages')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async {
        if (doc['messengerID'] == user2again.id) {
          if (doc['username'] == user2ID) {
            messageFound = true;
            log("MESSAGE FOUND");
            docReference = doc.id;
            messageArray.add(doc.id);
            log("\n\nDOC REFERENCE:");
            log(docReference.toString());
          }
        } else {
          messageFound = false;
          log("MESSAGE FOUND FALSE");
        }
      });
    });
    //log(messageFound.toString());

    if (messageFound == true) {
      log('ATTEMPTING TO ADD TEXT TO FOUND MESSAGE');
      var textref = await user1again
          .collection('allMessages')
          .doc(docReference)
          .collection('allTexts')
          .get();
      // .add({'messageBody': hellotext, 'dateTime': DateTime.now()}).then(
      //     (value) => log("TEXT REFERNCE: " + value.id));
    } else if (messageFound == false) {
      log('ATTEMPTING TO CREATE NEW MESSAGE AND TEXT');
      log("USER 2: " + user2);
      log(user1);
      log(user2ID);
      var messageRef = await user1again
          .collection('allMessages')
          .add({'messengerID': user2, 'userID': user1, 'username': user2ID})
          .then((value) {
            message1id = value.id;
            messageArray.add(message1id);
          })
          .then((value) => log('MESSAGE REFERENCE: ' + message1id))
          .catchError((error) => log("Failed to send Message: $error"));

      var textref = await user1again
          .collection('allMessages')
          .doc(message1id)
          .collection('allTexts')
          .get();
      // .add({'messageBody': hellotext, 'dateTime': DateTime.now()}).then(
      //     (value) => log("TEXT REFERNCE: " + value.id));
    } else {
      log("SOMETHING WENT WRONG");
    }

    return messageArray;
  }

  Future<User> queryUser(String email) async {
    bool foundEmail = false;
    var myUser;
    //query the whole collection search by email
    var user = await users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print(doc["email"]);
        if (doc['email'] == email) {
          print("USER FOUND!!!");
          print(doc.data());
          foundEmail = true;
          myUser = User(
            name: doc['name'],
            username: doc['username'],
            email: doc['email'],
          );
        }
      });
    });
    return myUser;
  }

  // Future<String> queryMessage(String messageID, String userID) async {
  //   //query the whole collection search by email
  //   var message = await users.doc(userID).collection('allMessages').doc(messageID).get();
  //   return message;
  // }

  Future<List> queryAllUsers() async {
    bool foundEmail = false;
    bool matched = false;
    var userList = <User>[];

    //query the whole collection search by email
    var query = await users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print(doc["email"]);
        var currentUser = User(
          name: doc['name'],
          username: doc['username'],
          email: doc['email'],
        );
        userList.add(currentUser);
      });
    });
    return userList;
  }
}

// class AddUser extends StatelessWidget {
//   final String fullName;
//   final String username;
//   final String email;
//   final String password;

//   AddUser(this.fullName, this.email, this.username, this.password);

//   @override
//   Widget build(BuildContext context) {
//     // Create a CollectionReference called users that references the firestore collection
//     CollectionReference users = FirebaseFirestore.instance.collection('USERS');

//     Future<void> addUser() {
//       // Call the user's CollectionReference to add a new user
//       return users
//           .add({
//             'full_name': fullName, // John Doe
//             'username': username, // Stokes and Sons
//             'email': email,
//             'password': password // 42
//           })
//           .then((value) => print("User Added"))
//           .catchError((error) => print("Failed to add user: $error"));
//     }

//     return TextButton(
//       onPressed: addUser,
//       child: Text(
//         "Add User",
//       ),
//     );
//   }
// }
