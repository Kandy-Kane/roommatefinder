import 'dart:developer';

import 'package:flutter/material.dart';
//import 'dart:developer';
import 'package:email_auth/email_auth.dart';
import 'package:roommatefinder/tabs.dart';
import 'package:roommatefinder/user_Firebase.dart';
import 'reference.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'ad_helper.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignIn> {
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    // TODO: Initialize _bannerAd
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  void dispose() {
    // TODO: Dispose a BannerAd object
    _bannerAd.dispose();

    super.dispose();
  }

  bool _hidePassword = true;
  int _counter = 0;
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (_isBannerAdReady == true)
        Container(
          margin: EdgeInsets.only(bottom: 60, top: 0),

          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Color.fromARGB(255, 76, 84, 88)),
          width: _bannerAd.size.width.toDouble(),
          height: _bannerAd.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd),
        ),
      Form(
          key: _formKey,
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  child: Image(
                      image: AssetImage('lib/assets/images/schoolLogo.png')),
                ),
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
                      } //else if (!value.contains("manhattan.edu")) {
                      //   return 'Please use your Manhattan College Email';
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
                ),

                //SEND BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 0, 59, 2),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var db = Database();
                      print("CONTROLLER 1 TEXT: " + myController.text + "\n");
                      print("CONTROLLER 2 TEXT: " + myController2.text);
                      var user = await db.findUser(
                          myController.text, myController2.text);
                      print("USER FOUND?: " + user.toString());
                      if (user == true) {
                        var userTemp = await db.queryUser(myController.text);

                        var userID = await db.getUserIDFromUsername(
                            userTemp.username.toString());
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
          ))
    ]);
  }
}
