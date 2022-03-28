import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/emailAuthClass.dart';
import 'package:roommatefinder/tabs.dart';
import 'package:roommatefinder/verificationPage.dart';
import 'reference.dart';
import 'mongodbAttempt/mongouserClass.dart';
import 'mongodbAttempt/database.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'user_Firebase.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Register> {
  bool _hidePassword = true;
  bool _hideReEnterPassword = true;
  static var myAuth;
  int _counter = 0;
  var db = Database();
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //const specialChars = /[`!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?~]/;

//EMAIL VERIFICATION METHODS
  // var emailAuth = EmailAuth(sessionName: "Roommate Finder Session");

  // void sendOTP() async {
  //   bool result = await emailAuth.sendOtp(
  //       recipientMail: myController3.text, otpLength: 5);
  //   if (result) {
  //     log("OTP SENT!");
  //     _showMyDialog();
  //   } else {
  //     log('problem did not send');
  //   }
  // }

  // void verifyOTP() async {
  //   var res = emailAuth.validateOtp(
  //       recipientMail: myController.text, userOtp: myController2.text);
  //   if (res) {
  //     log("OTP VERFIED");
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const TabBarDemo()),
  //     );
  //     myController.clear();
  //     myController2.clear();
  //   } else {
  //     log("OTP INVALID");
  //   }
  // }

  // void registerUser() async {
  //   final user = User(
  //       id: M.ObjectId(),
  //       name: myController.text,
  //       username: myController2.text,
  //       email: myController3.text,
  //       password: myController4.text);
  //   // await MongoDatabase.insert(user);
  //   // Navigator.pop(context);
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
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 150,
                child: Image(
                    image: AssetImage('lib/assets/images/schoolLogo.png')),
              ),
              Container(
                width: 325,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 76, 84, 88)),
                child: TextFormField(
                  controller: myController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
              ),
              Container(
                width: 325,
                margin: new EdgeInsets.symmetric(vertical: 5.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 76, 84, 88)),
                child: TextFormField(
                  controller: myController2,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  //controller: myController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),

              Container(
                width: 325,
                margin: new EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 76, 84, 88)),
                child: TextFormField(
                  controller: myController3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (!value.contains("manhattan.edu")) {
                      return 'Please use your Manhattan College Email';
                    }
                    // else if (db.checkForDuplicateEmail(value) == true) {
                    //   return 'Your email is already registered';
                    // }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter Your Email',
                  ),
                ),
              ),

              Container(
                width: 325,
                margin: new EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 76, 84, 88)),
                child: TextFormField(
                    controller: myController4,
                    obscureText: _hidePassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Create A Password',
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
              ),
              Container(
                width: 325,
                margin: new EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 76, 84, 88)),
                child: TextFormField(
                    controller: myController5,
                    obscureText: _hideReEnterPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Re-Enter Your Password';
                      } else if (value != myController4.text) {
                        return 'Passwords Do Not Match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Re-Enter Password',
                      suffixIcon: IconButton(
                          icon: Icon(_hideReEnterPassword
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _hideReEnterPassword = !_hideReEnterPassword;
                            });
                          }),
                    )),
              ),

              //SEND BUTTON
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 0, 59, 2),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                onPressed: () async {
                  var emailAlreadyRegistered =
                      await db.checkForDuplicateEmail(myController3.text);
                  if (emailAlreadyRegistered == true) {
                    _duplicateEmailFound();
                  } else {
                    if (_formKey.currentState!.validate()) {
                      // Respond to button press
                      //sendOTP();
                      myAuth = emailAuthClass(myController3.text);
                      int result = await myAuth.sendOTP();
                      log(result.toString());
                      if (result == 1) {
                        log(myController3.text);
                        _showMyDialog();
                      } else {}
                      log(myController3.text);
                    }
                  }
                },
                child: Text('Send Verification Code'),
              ),

              // ElevatedButton(
              //   onPressed: () {
              //     // Respond to button press
              //     verifyOTP();
              //     log(myController.text);
              //   },
              //   child: Text('VERIFY OTP'),
              // ),

              // ElevatedButton(
              //   onPressed: () {
              //     var db = Database();
              //     db.addUser(myController.text, myController2.text,
              //         myController3.text, myController4.text);
              //     // Respond to button press
              //     Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(builder: (context) => const TabBarDemo()),
              //     );
              //   },
              //   child: Text('DEVELOPING'),
              // )
            ],
          ),
        ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('EMAIL SENT'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('VERIFICATION EMAIL SENT'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => otpVerification(
                          emailAuthFinal: myAuth,
                          name: myController.text,
                          username: myController2.text,
                          email: myController3.text,
                          password: myController4.text)),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _duplicateEmailFound() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Email Already Registered'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Your email is already registered. Try signing In.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
