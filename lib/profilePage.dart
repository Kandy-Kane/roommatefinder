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

class profilePage extends StatefulWidget {
  profilePage({Key? key, required this.user}) : super(key: key);
  User user;
  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  String errorMsg = 'Image Not Found';

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
        .child(widget.user.email + ":Profile Pic")
        .getData(10000000);
    // log(imageBytes.toString());
    setState(() {
      profilePic = imageBytes;
    });
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
              maxLines: 5,
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

  final picker = ImagePicker();
  File _imageFile = File('');

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(pickedFile!.path);
    });
    uploadImageToFirebase(context);
  }

  Future uploadImageToFirebase(BuildContext context) async {
    String fileName = Path.basename(_imageFile.path);
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child(widget.user.email + ":Profile Pic");
    firebase_storage.UploadTask uploadTask =
        firebaseStorageRef.putFile(_imageFile);
    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => null);
    taskSnapshot.ref.getDownloadURL().then(
          (value) => log("Done: $value"),
        );
    getProfilePicInfo();
  }

  @override
  Widget build(BuildContext context) {
    var img = profilePic != null
        ? Image.memory(
            profilePic,
            fit: BoxFit.fitHeight,
          )
        : Text(errorMsg != null ? errorMsg : "Loading...");
    var changedBio = initialText;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 4, 43, 5),
        body: Column(children: [
          Flexible(
              //========================Picture Holder=====================//
              child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: 1,
                  child: Container(
                      child: InkWell(
                          onTap: pickImage, child: Container(child: img))))),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    width: 5.0, color: Color.fromARGB(255, 255, 213, 0)),
              ),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 10, 6, 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 238, 194, 49),
                      fontSize: 27.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
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
                    widget.user.username,
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
            // onTap: () {
            //   setState(() {
            //     _isEditingText = true;
            //   });
            // },
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
                    initialText,
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
                    widget.user.email,
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
          Row(
            children: [
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
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                      );
                    }),
              ),
            ],
          )
        ]));
  }
}
