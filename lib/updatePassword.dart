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
import 'package:roommatefinder/forgotPassword.dart';
import 'userClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// init("ANNdWnd1Kk-RNpuBx");
// import  'emailjs-com';

class updatePassword extends StatefulWidget {
  updatePassword({Key? key, required this.user}) : super(key: key);
  User user;
  @override
  State<updatePassword> createState() => _updatePasswordState();
}

class _updatePasswordState extends State<updatePassword> {
  var collection = FirebaseFirestore.instance.collection('USERS');
  late BannerAd _bannerAd;
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
          'template_params': {'to_name': name, 'message': message}
        }));
    return response.statusCode;
  }

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
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Center(
      child:
          // if (_isBannerAdReady == true)
          //   Container(
          //     margin: EdgeInsets.only(bottom: 5, top: 0),

          //     // decoration: BoxDecoration(
          //     //     borderRadius: BorderRadius.circular(10),
          //     //     color: Color.fromARGB(255, 76, 84, 88)),
          //     width: _bannerAd.size.width.toDouble(),
          //     height: _bannerAd.size.height.toDouble(),
          //     child: AdWidget(ad: _bannerAd),
          //   ),
          // Container(
          //   child: FutureBuilder(
          //     future: _initializeVideoPlayerFuture,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.done) {
          //         // If the VideoPlayerController has finished initialization, use
          //         // the data it provides to limit the aspect ratio of the video.
          //         return AspectRatio(
          //           aspectRatio: _controller.value.aspectRatio,
          //           // Use the VideoPlayer widget to display the video.
          //           child: VideoPlayer(_controller),
          //         );
          //       } else {
          //         // If the VideoPlayerController is still initializing, show a
          //         // loading spinner.
          //         return const Center(
          //           child: CircularProgressIndicator(),
          //         );
          //       }
          //     },
          //   ),
          // ),
          // FloatingActionButton(
          //   onPressed: () {
          //     // Wrap the play or pause in a call to `setState`. This ensures the
          //     // correct icon is shown.
          //     setState(() {
          //       // If the video is playing, pause it.
          //       if (_controller.value.isPlaying) {
          //         _controller.pause();
          //       } else {
          //         // If the video is paused, play it.
          //         _controller.play();
          //       }
          //     });
          //   },
          //   // Display the correct icon depending on the state of the player.
          //   child: Icon(
          //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          //   ),
          // ),
          Form(
              key: _formKey,
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Container(
                margin: const EdgeInsets.only(bottom: 100.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   width: 200,
                    //   height: 200,
                    //   child: Image(
                    //       image:
                    //           AssetImage('lib/assets/images/schoolLogo.png')),
                    // ),
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
                    Container(
                      width: 325,
                      margin: EdgeInsets.only(bottom: 10),
                      // margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 76, 84, 88)),
                      child: TextFormField(
                          style: TextStyle(
                              fontSize: 20.0, height: 2.0, color: Colors.black),
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
                            labelText: 'Enter Current Password',
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
                      margin: EdgeInsets.only(bottom: 10),
                      // margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 76, 84, 88)),
                      child: TextFormField(
                          style: TextStyle(
                              fontSize: 20.0, height: 2.0, color: Colors.black),
                          controller: myController3,
                          obscureText: _hidePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter New Password',
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
                      margin: EdgeInsets.only(bottom: 10),
                      // margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 76, 84, 88)),
                      child: TextFormField(
                          style: TextStyle(
                              fontSize: 20.0, height: 2.0, color: Colors.black),
                          controller: myController4,
                          obscureText: _hidePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            } else if (myController3.text != value) {
                              return 'Your new password doesn\'t match';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter New Password Again',
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
                      child: TextButton(
                        child: Text('Forgot Password'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ));
                        },
                      ),
                    ),

                    //SEND BUTTON
                    Container(
                        // margin: EdgeInsets.only(bottom: 500.0),
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 0, 59, 2),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var db = Database();
                          print(
                              "CONTROLLER 1 TEXT: " + myController.text + "\n");
                          print("CONTROLLER 2 TEXT: " + myController2.text);
                          var user = await db.findUser(
                              myController.text, myController2.text);
                          print("USER FOUND?: " + user.toString());
                          if (user == true) {
                            await changePassword(myController4.text);
                            myController3.clear();
                            myController4.clear();
                            myController2.clear();
                            _passwordSuccessfullyChanged();
                            // Navigator.pushReplacement(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => TabBarDemo(
                            //             email: myController.text,
                            //             tabUser: userTemp,
                            //             userID: userID,
                            //           )),
                            // );
                          } else {
                            log("\nSOMETHING WRONG HAPPENDED OR USER NOT FOUND\n");
                            _passwordDoesNotMatch();
                          }
                        }
                        // Respond to button press
                      },
                      child: Text('Change Password'),
                    )),
                  ],
                ),
              )),
      // if (_isBannerAdReady == true)
      //   Container(
      //     alignment: Alignment.bottomCenter,
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10),
      //         color: Color.fromARGB(255, 76, 84, 88)),
      //     width: _bannerAd.size.width.toDouble(),
      //     height: _bannerAd.size.height.toDouble(),
      //     child: AdWidget(ad: _bannerAd),
      //   ),
    )));
  }

  Future<void> changePassword(newPassword) async {
    var userID = await db.getUserIDFromUsername(widget.user.username);
    await collection.doc(userID).update({'password': newPassword});
  }

  Future<void> updatePassword() async {
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

  Future<void> _passwordSuccessfullyChanged() async {
    var userID = await db.getUserIDFromUsername(widget.user.username);
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Changed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Your Password was successfully changed'),
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
                      builder: (context) => TabBarDemo(
                            email: myController.text,
                            tabUser: widget.user,
                            userID: userID,
                          )),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
