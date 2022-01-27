import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'dart:developer';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'functions.dart';
import 'package:email_auth/email_auth.dart';
import 'reference.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.red),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final myController = TextEditingController();
  final myController2 = TextEditingController();

//EMAIL VERIFICATION METHODS
  var emailAuth = EmailAuth(sessionName: "testsesstion");

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
        MaterialPageRoute(builder: (context) => const SecondRoute()),
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
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //NAME FIELD
            // TextFormField(
            //   decoration: const InputDecoration(
            //     border: UnderlineInputBorder(),
            //     labelText: 'Enter Your Name',
            //   ),
            // ),

            // //BIRTHDAY FIELD
            // TextFormField(
            //   decoration: const InputDecoration(
            //     border: UnderlineInputBorder(),
            //     labelText: 'Enter Your BirthDay',
            //   ),
            // ),

            //EMAIL FIELD

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
                labelText: 'ENTER OTP',
              ),
            ),

            //SEND BUTTON
            ElevatedButton(
              onPressed: () {
                // Respond to button press
                sendOTP();
                log(myController.text);
              },
              child: Text('SEND!'),
            ),

            ElevatedButton(
              onPressed: () {
                // Respond to button press
                verifyOTP();
                log(myController.text);
              },
              child: Text('VERIFY OTP'),
            )
          ],
        ),
      ),
    );
  }
}

// Future<void> sendEmail(emailName) async {
//   final Email email = Email(
//     body: 'If youre receiving this good job',
//     subject: 'Roommate Finder Test',
//     recipients: [emailName],
//     // cc: ['cc@example.com'],
//     // bcc: ['bcc@example.com'],
//     // attachmentPaths: ['/path/to/attachment.zip'],
//     isHTML: false,
//   );
//   await FlutterEmailSender.send(email);
// }


