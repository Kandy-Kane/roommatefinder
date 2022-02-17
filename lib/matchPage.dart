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
import 'selectedProfilePage.dart';

class matchPage extends StatefulWidget {
  const matchPage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _matchPageState createState() => _matchPageState();
}

class _matchPageState extends State<matchPage> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  var collection = FirebaseFirestore.instance.collection('USERS');

  // Stream<QuerySnapshot> snaps2 = FirebaseFirestore.instance
  //     .collection('USERS')
  //     .orderBy('name')
  //     .snapshots();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> snaps = FirebaseFirestore.instance
        .collection('USERS')
        .where('name', isNotEqualTo: widget.user.name)
        .orderBy('name')
        .snapshots();
    var db = Database();
    return Scaffold(

        // appBar: AppBar(
        //   title: Text("Notes"),
        //   centerTitle: true,
        // ),
        body: Column(
      children: [
        Row(children: [
          Expanded(
              child: TextFormField(
            controller: myController,
            onChanged: (value) async {
              setState(() {
                if (value == "") {
                  snaps = FirebaseFirestore.instance
                      .collection('USERS')
                      .orderBy('name')
                      .snapshots();
                } else {
                  snaps = collection
                      .where('name', isGreaterThanOrEqualTo: value)
                      .where('name', isLessThan: value + 'z')
                      .snapshots();
                  // snaps2 = collection
                  //     .where('email', isGreaterThanOrEqualTo: value)
                  //     .where('email', isLessThan: value + 'z')
                  //     .snapshots();
                }
              });
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Search Using Name',
            ),
          )),
          Expanded(
              flex: 0,
              child: IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Change Preferences',
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Positioned(
                                right: -40.0,
                                top: -40.0,
                                child: InkResponse(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: CircleAvatar(
                                    child: Icon(Icons.close),
                                    backgroundColor: Colors.red,
                                  ),
                                ),
                              ),
                              Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: Text("Major"),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: TextFormField(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: TextFormField(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: TextFormField(),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1.0),
                                      child: TextFormField(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        child: Text("Submitß"),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
              )),
        ]),
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
                              builder: (context) => selectedProfilePage(
                                    user: widget.user,
                                    selectedUser: selectedUser,
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
}
