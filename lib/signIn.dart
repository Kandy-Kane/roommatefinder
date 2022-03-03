import 'dart:developer';

import 'package:flutter/material.dart';
//import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/tabs.dart';
import 'package:roommatefinder/user_Firebase.dart';
import 'reference.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  State<SignIn> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignIn> {
  bool _hidePassword = true;
  int _counter = 0;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Future<void> _showMyDialog() async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('EMAIL SENT'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: const <Widget>[
  //               Text('VERIFICATION EMAIL SENT'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('CLOSE'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Form(
      key: _formKey,
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: myController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              } //else if (!value.contains("manhattan.edu")) {
              //   return 'Please use your Manhattan College Email';
              // }
              return null;
            },
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter Your Email',
            ),
          ),

          TextFormField(
              controller: myController2,
              obscureText: _hidePassword,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Password',
                suffixIcon: IconButton(
                    icon: Icon(_hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _hidePassword = !_hidePassword;
                      });
                    }),
              )),

          //SEND BUTTON
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                var db = Database();
                print("CONTROLLER 1 TEXT: " + myController.text + "\n");
                print("CONTROLLER 2 TEXT: " + myController2.text);
                var user =
                    await db.findUser(myController.text, myController2.text);
                print("USER FOUND?: " + user.toString());
                if (user == true) {
                  var userTemp = await db.queryUser(myController.text);

                  var userID = await db
                      .getUserIDFromUsername(userTemp.username.toString());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TabBarDemo(
                              email: myController.text,
                              tabUser: userTemp,
                              userID: userID,
                            )),
                  );
                } else {
                  log("\nSOMETHING WRONG HAPPENDED OR USER NOT FOUND\n");
                }
              }
              // Respond to button press
            },
            child: Text('Sign In'),
          )
        ],
      ),
    );
  }
}
