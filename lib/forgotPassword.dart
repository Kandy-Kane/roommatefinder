import 'dart:developer';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter/material.dart';
//import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/tabs.dart';
import 'package:roommatefinder/user_Firebase.dart';
import 'reference.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show json;
import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server.dart';
// init("ANNdWnd1Kk-RNpuBx");
// import  'emailjs-com';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String cancelOrGoBack = 'Cancel';
  bool buttonenabled = true;
  // late BannerAd _bannerAd;
  bool _isBannerAdReady = false;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  var db = Database();

  @override
  void initState() {
    // TODO: Initialize _bannerAd
    // _bannerAd = BannerAd(
    //   adUnitId: AdHelper.bannerAdUnitId,
    //   request: AdRequest(),
    //   size: AdSize.banner,
    //   listener: BannerAdListener(
    //     onAdLoaded: (_) {
    //       setState(() {
    //         _isBannerAdReady = true;
    //       });
    //     },
    //     onAdFailedToLoad: (ad, err) {
    //       print('Failed to load a banner ad: ${err.message}');
    //       _isBannerAdReady = false;
    //       ad.dispose();
    //     },
    //   ),
    // );

    // _bannerAd.load();
    // _controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    // );

    // _initializeVideoPlayerFuture = _controller.initialize();
  }

  Future sendEmail(String name, String email, String message) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    const serviceId = 'service_8icvl2b';
    const templateId = 'template_hs21lvo';
    const userId = 'ANNdWnd1Kk-RNpuBx';
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json'
        }, //This line makes sure it works for all platforms.
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'from_name': "Roommate Finder",
            'to_name': name,
            'message': message,
            'to_email': email,
          }
        }));

    return response.statusCode;
  }

  // Future sendEmail(String name, String userEmail, String userMessage) async {
  //   final email = 'RoommateFinderEmailService@gmail.com';
  //   // String password = '1qaz2wsx!QAZ@WSX';
  //   // final smtpServer = gmail(username, password);

  //   final message = Message()
  //     ..from = Address(email)
  //     ..recipients = [userEmail]
  //     ..subject = 'Roommate Password Recovery'
  //     ..text = userMessage;

  //   try {
  //     await send(message);
  //     print('Message sent: ');
  //     return '200';
  //   } on MailerException catch (e) {
  //     print('Message not sent.');
  //     for (var p in e.problems) {
  //       log(p.toString());
  //     }
  //   }
  // }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    // _bannerAd.dispose();
    _controller.dispose();
    super.dispose();
  }

  bool _hidePassword = true;
  int _counter = 0;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // var forgotPasswordController = TextEditingController();
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Form(
              key: _formKey,
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Container(
                margin: const EdgeInsets.only(bottom: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      width: 325,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 76, 84, 88)),
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 20.0, height: 2.0, color: Colors.black),
                        controller: myController,
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
                          filled: true,
                          border: UnderlineInputBorder(),
                          labelText: 'Enter Your Email',
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text(cancelOrGoBack),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Continue'),
                      onPressed: buttonenabled
                          ? () async {
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }
                              var userEmail = myController.text;
                              log(userEmail);
                              var forgotPasswordReturns =
                                  await db.forgotPasswordReturn(userEmail);
                              log(forgotPasswordReturns.toString());
                              if (forgotPasswordReturns.isNotEmpty) {
                                var userName =
                                    forgotPasswordReturns[0].toString();
                                var userPassword =
                                    forgotPasswordReturns[1].toString();
                                log('INFORMATION:' +
                                    userEmail +
                                    ":" +
                                    userName +
                                    ":" +
                                    userPassword);
                                var message =
                                    'Your password is: ${userPassword}';
                                log(message);
                                try {
                                  var attempt = await sendEmail(
                                      userName, userEmail, message);
                                  if (attempt == 200) {
                                    setState(() {
                                      buttonenabled = false;
                                      cancelOrGoBack = 'Go Back';
                                    });
                                  }
                                  log(attempt.toString());
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    attempt == 200
                                        ? const SnackBar(
                                            content: Text('Message Sent!'),
                                            backgroundColor: Colors.green)
                                        : const SnackBar(
                                            content:
                                                Text('Failed to send message!'),
                                            backgroundColor: Colors.red),
                                  );
                                } catch (e) {
                                  log(e.toString());
                                }
                              } else {
                                log('Couldnt find email');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Couldnt find email!'),
                                      backgroundColor: Colors.red),
                                );
                              }

                              // try {
                              //   var attempt = await sendEmail(userName, userEmail, message);
                              //   // log('attempt:' + attempt.toString());
                              //   log('success');
                              // } catch (e) {
                              //   log(e.toString());
                              // }
                            }
                          : null,
                    ),

                    //SEND BUTTON
                  ],
                ),
              ))
        ])));
  }

  Future<void> ForgotPassword() async {
    var forgotPasswordController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('Enter Your Email'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Enter your Email'),
                TextField(
                  controller: forgotPasswordController,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('Continue'),
              onPressed: () async {
                var userEmail = forgotPasswordController.text;
                log(userEmail);
                var forgotPasswordReturns =
                    await db.forgotPasswordReturn(userEmail);
                log(forgotPasswordReturns.toString());
                var userName = forgotPasswordReturns[0].toString();
                var userPassword = forgotPasswordReturns[1].toString();

                log('INFORMATION:' +
                    userEmail +
                    ":" +
                    userName +
                    ":" +
                    userPassword);
                var message = 'Your password is: ${userPassword}';
                log(message);
                try {
                  var attempt = await sendEmail(userName, userEmail, message);
                  log(attempt.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    attempt == 200
                        ? const SnackBar(
                            content: Text('Message Sent!'),
                            backgroundColor: Colors.green)
                        : const SnackBar(
                            content: Text('Failed to send message!'),
                            backgroundColor: Colors.red),
                  );
                } catch (e) {
                  log(e.toString());
                }

                // try {
                //   var attempt = await sendEmail(userName, userEmail, message);
                //   // log('attempt:' + attempt.toString());
                //   log('success');
                // } catch (e) {
                //   log(e.toString());
                // }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _passwordDoesNotMatch() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password or Email Do Not Match'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Your Password or email do Not Match. Try a different password/email or use Forgot Password. '),
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
