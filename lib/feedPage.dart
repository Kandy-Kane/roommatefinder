import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:developer';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:roommatefinder/main.dart';
import 'package:roommatefinder/profilePage.dart';
import 'package:roommatefinder/user_Firebase.dart';
import 'functions.dart';
import 'package:email_auth/email_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'userClass.dart';

class feedPage extends StatefulWidget {
  const feedPage({Key? key}) : super(key: key);

  @override
  _feedPageState createState() => _feedPageState();
}

class _feedPageState extends State<feedPage> {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('USERS');

  @override
  Widget build(BuildContext context) {
    var db = Database();
    //collection.orderBy('name');
    // final CollectionReference users =
    //     FirebaseFirestore.instance.collection('USERS');
    //users.orderBy('name');
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Notes"),
      //   centerTitle: true,
      // ),
      body: StreamBuilder<QuerySnapshot>(
        stream: collection.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: (snapshot.data! as QuerySnapshot).docs.map((doc) {
                return Card(
                  child: ListTile(
                    leading: FlutterLogo(size: 56.0),
                    title: Text(doc['name']),
                    subtitle: Text(doc['email']),
                    //trailing: Icon(Icons.more_vert),
                    onTap: () async {
                      var db = Database();
                      var selectedUser = await db.queryUser(doc['email']);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              profilePage(user: selectedUser)));
                    },
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
