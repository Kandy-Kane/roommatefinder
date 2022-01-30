import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mongo_dart/mongo_dart.dart';

class Database {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('USERS');

  Future<void> addUser(
      String fullName, String username, String email, String password) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': fullName, // John Doe
          'username': username, // Stokes and Sons
          'email': email,
          'password': password // 42
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<bool> findUser(String username, String password) async {
    bool foundEmail = false;
    bool matched = false;
    //query the whole collection search by email
    var user = await users.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        //print(doc["email"]);
        if (doc['email'] == username) {
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
