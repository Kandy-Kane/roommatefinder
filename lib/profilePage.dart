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

class profilePage extends StatefulWidget {
  profilePage({Key? key, required this.user}) : super(key: key);
  User user;
  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  var collection = FirebaseFirestore.instance.collection('USERS');
  bool _isEditingText = false;
  final TextEditingController _editingController = TextEditingController();
  late String initialText;
  var db = Database();

  @override
  void initState() {
    super.initState();
    _editingController.text = widget.user.bio;
    initialText = widget.user.bio;
  }

  // @override
  // void dispose() {
  //   _editingController.dispose();
  //   super.dispose();
  // }

  void editBio() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Your Bio'),
          content: SingleChildScrollView(
              child: Center(
            child: TextField(
              minLines: 1,
              maxLines: 10,
              // onSubmitted: (newValue) {
              //   setState(() {
              //     initialText = newValue;
              //     _isEditingText = false;
              //   });
              // },
              autofocus: true,
              controller: _editingController,
            ),
          )),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () async {
                var UID = await db.getUserIDFromUsername(widget.user.username);
                var user = await collection.doc(UID);
                await user.update({'bio': _editingController.text});
                setState(() {
                  initialText = _editingController.text;
                  widget.user.bio = _editingController.text;
                });

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var changedBio = initialText;
    return Scaffold(
        body: Column(children: [
      Flexible(
          child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 0.6,
              child: GestureDetector(
                child: Container(
                  child: Image.asset('lib/assets/images/logo.jpg'),
                ),
              ))),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(widget.user.username,
            textAlign: TextAlign.left, textScaleFactor: 4.0),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(widget.user.name,
            textAlign: TextAlign.left, textScaleFactor: 2.0),
      ),
      Container(
        alignment: Alignment.centerLeft,
        child: Text(widget.user.email,
            textAlign: TextAlign.left, textScaleFactor: 2.0),
      ),
      Container(
          alignment: Alignment.centerLeft,
          // onTap: () {
          //   setState(() {
          //     _isEditingText = true;
          //   });
          // },
          child: Text(
            initialText,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          )),
      Container(
        alignment: Alignment.centerLeft,
        child: ElevatedButton(
            child: const Text('Edit Bio'),
            onPressed: () {
              editBio();
            }),
      ),
      Container(
        // alignment: Alignment.centerLeft,
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
//   Widget bioTextField() {
//     return Column(children: [
//       Center(
//         child: TextField(
//           minLines: 1,
//           maxLines: 10,
//           onSubmitted: (newValue) {
//             setState(() {
//               initialText = newValue;
//               _isEditingText = false;
//             });
//           },
//           autofocus: true,
//           controller: _editingController,
//         ),
//       )
//     ]);
//   }
// }
