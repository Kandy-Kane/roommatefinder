import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/tabs.dart';
import 'reference.dart';

// class SignIn extends StatelessWidget {
//   const SignIn({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           // This is the theme of your application.
//           //
//           // Try running your application with "flutter run". You'll see the
//           // application has a blue toolbar. Then, without quitting the app, try
//           // changing the primarySwatch below to Colors.green and then invoke
//           // "hot reload" (press "r" in the console where you ran "flutter run",
//           // or simply save your changes to "hot reload" in a Flutter IDE).
//           // Notice that the counter didn't reset back to zero; the application
//           // is not restarted.
//           primarySwatch: Colors.red),
//       home: const SignIn(),
//     );
//   }
// }

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
  int _counter = 0;
  final myController = TextEditingController();
  final myController2 = TextEditingController();

//EMAIL VERIFICATION METHODS
  var emailAuth = EmailAuth(sessionName: "testsession");

  void sendOTP() async {
    bool result =
        await emailAuth.sendOtp(recipientMail: myController.text, otpLength: 5);
    if (result) {
      log("OTP VERIFIED");
      _showMyDialog();
    } else {
      log('problem');
    }
  }

  void verifyOTP() async {
    var res = emailAuth.validateOtp(
        recipientMail: myController.text, userOtp: myController2.text);
    if (res) {
      log("OTP VERFIED");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const TabBarDemo()),
      );
      myController.clear();
      myController2.clear();
    } else {
      log("OTP INVALID");
    }
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: myController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Your Email',
              ),
            ),

            TextFormField(
              controller: myController2,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Password',
              ),
            ),

            //SEND BUTTON
            ElevatedButton(
              onPressed: () {
                // Respond to button press
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const TabBarDemo()),
                );
              },
              child: Text('Sign In'),
            )
          ],
        ),
      ),
    );
  }
}
