import 'dart:async';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:project_stands/sounds.dart';
import 'package:project_stands/quiz_page.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:project_stands/all_stands.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() => runApp(MaterialApp(home: VideoPlayerApp()));

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      title: 'Video Player Demo',
      home: VideoPlayerScreen(),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.asset(
      'assets/jojo1-3_Trim_Trim.mp4',
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: GradientAppBar(
        actions: <Widget>[
          Container(
              width: 110,
              child: Image.asset('assets/jojo_text-removebg-preview.png')),
        ],
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[Colors.purple[800], Colors.black87]),
        title: Text('Project JoJo'),
      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the VideoPlayerController has finished initialization, use
              // the data it provides to limit the aspect ratio of the video.
              return AspectRatio(
                aspectRatio: 20.0 / 32.0,
                // Use the VideoPlayer widget to display the video.
                child: VideoPlayer(_controller),
              );
            } else {
              // If the VideoPlayerController is still initializing, show a
              // loading spinner.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [Colors.purple[900], Colors.black])),
                child: DrawerHeader(
                    child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xFF4A148C),
                  child: CircleAvatar(
                      radius: 67,
                      backgroundImage: AssetImage(
                        'assets/images/jotaro.jpg',
                      )),
                )),
              ),
              Container(
                  color: Colors.black87,
                  child: Column(children: [
                    ListTile(
                      //contentPadding: EdgeInsets.only(right: 0),
                      leading: Icon(Icons.library_music, color: Colors.white54),
                      title: Text(
                        'SoundBoard',
                        //textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).push(_createRoute());
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.star_border, color: Colors.white54),
                      title: Text(
                        'JBA Quiz',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).push(_createRoute2());
                      },
                    ),
                    ListTile(
                      leading: Icon(MdiIcons.omega, color: Colors.white54),
                      title: Text(
                        'All Stands',
                        style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w400,
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).push(_createRoute3());
                      },
                    ),
                    Container(
                      height: 410,
                      width: 200,
                      child: Image.asset(
                        'assets/menacing-removebg-preview.png',
                        height: 1000,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 2.0, color: Color(0xFFFF000000)),
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          'Version 1.0.0.1*',
                          style: TextStyle(
                              color: Colors.white30,
                              fontWeight: FontWeight.w400,
                              fontSize: 15),
                        ),
                      ),
                    )
                  ]))
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[900],

        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute2() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => QuizPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route _createRoute3() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AllStands(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class Page2 extends StatefulWidget {
  Page2({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _Page2State createState() => _Page2State();
}
//

//
//

class _Page2State extends State<Page2> {
  AudioCache audioCache;
  AudioPlayer audioPlayer;
  int indexIsPlaying;

  final List _wows = WowSounds().wows;

  @override
  void initState() {
    super.initState();
    initSounds();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //
    //
    //
    //
    List<String> _descriptions = [
      'Bites-Za-Dusto',
      'bloody-Stream',
      'brakedown-1',
      'brakedown-2',
      'brakedown-3',
      'brakedown-4',
      'Dio!',
      'Durararara',
      'Do You Understand',
      'Emerado-Splash',
      'Go Ahead Mister Joster',
      'Go Bi O Keka',
      'Goodbye JoJo',
      'Gureto Desu Yo',
      'Happy Urepiku Ne',
      'Hey Baby',
      'Hinjaku Hinjaku',
      'Kars Laugh',
      'Kira Queen',
      'Kono Dio Daaaa!',
      'Kono Dio Da!',
      'Morio Cho Radio',
      'Muda Muda Muda',
      'Nigerundayo',
      'Niiiiice',
      'Oh My God!',
      'Oh Nooo!!',
      'Oh Noooo!(Young Joseph)',
      'Oh Shit!',
      'Ora Ora Ora',
      'Rero Rero Rero',
      'Rodo Rolla Ga',
      'Roku Bi O Keka',
      'San Bi O Keka',
      'Silver Chariot',
      'Sono Chi No Sadame',
      'Son Of A Bitch',
      'Time Stop',
      'Tokio Tomare',
      'Very Nice Ceasar Chan',
      'Kureee!',
      'Yare Yare Daze',
      'Yes I Am',
      'Yiom Bi O Keka',
      'Za Warudo',
    ];
    List<String> _headshots = [
      'assets/images/sound_board_images/killer queen squidward.png',
      'assets/images/sound_board_images/bloody stream.jpg',
      'assets/images/sound_board_images/breakdown 2.jpg',
      'assets/images/sound_board_images/breakdown 2.jpg',
      'assets/images/sound_board_images/breakdown 2.jpg',
      'assets/images/sound_board_images/breakdown 2.jpg',
      'assets/images/sound_board_images/johnathon young.jfif',
      'assets/images/sound_board_images/crazy diamond.jpg',
      'assets/images/sound_board_images/rubber soul.jpg',
      'assets/images/sound_board_images/emerald splash.jpg',
      'assets/images/sound_board_images/d darby.png',
      'assets/images/sound_board_images/go bi o keka.jpg',
      'assets/images/sound_board_images/goodbye jojo2.gif',
      'assets/images/sound_board_images/gureto desu yo.jpg',
      'assets/images/sound_board_images/happy urepi.gif',
      'assets/images/sound_board_images/hey baby.jpg',
      'assets/images/sound_board_images/hinjaku hinjaku.gif',
      'assets/images/sound_board_images/kars.png',
      'assets/images/sound_board_images/kira queen.jpg',
      'assets/images/sound_board_images/kono dio da.jpg',
      'assets/images/sound_board_images/kono dio da.jpg',
      'assets/images/sound_board_images/morio cho radio.jpg',
      'assets/images/sound_board_images/muda muda.gif',
      'assets/images/sound_board_images/nigerundayo.jpg',
      'assets/images/sound_board_images/nice.png',
      'assets/images/sound_board_images/oh my god.jpg',
      'assets/images/sound_board_images/oh no.png',
      'assets/images/sound_board_images/oh no young.jpg',
      'assets/images/sound_board_images/oh shit.gif',
      'assets/images/sound_board_images/ora ora.jfif',
      'assets/images/sound_board_images/relo relo relo.gif',
      'assets/images/sound_board_images/roada rolla da.jpg',
      'assets/images/sound_board_images/go bi o keka.jpg',
      'assets/images/sound_board_images/go bi o keka.jpg',
      'assets/images/sound_board_images/silver chariot.png',
      'assets/images/sound_board_images/sono chi no sadame.jpg',
      'assets/images/sound_board_images/son of a bitch.jpg',
      'assets/images/sound_board_images/time stop.gif',
      'assets/images/sound_board_images/toki yo tomare.jfif',
      'assets/images/sound_board_images/very nice caesar chan.png',
      'assets/images/sound_board_images/kuree.jfif',
      'assets/images/sound_board_images/yare yare daze.gif',
      'assets/images/sound_board_images/yes i am.jpg',
      'assets/images/sound_board_images/go bi o keka.jpg',
      'assets/images/sound_board_images/za warudo.gif',
    ];

    //
    //
    //
    //
    //

    @override
    Widget listStuff =
        /*Column(
        //controller: _controller,
        //physics: const AlwaysScrollableScrollPhysics(),
        //mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [*/
        GridView.builder(
            padding: EdgeInsets.only(top: 10),
            shrinkWrap: true,
            itemCount: 45,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              crossAxisCount: 3,
            ),
            itemBuilder: (BuildContext context, int index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        child: Container(
                          height: 90,
                          width: 90,
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0),
                            image: DecorationImage(
                              image: AssetImage(_headshots[index % 45]),
                              fit: BoxFit.fill,
                            ),
                            color: Colors.black,
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                          ),
                        ),
                        onTap: () {
                          if (mounted)
                            setState(() {
                              playSound(_wows[index]);
                              indexIsPlaying = index;
                            });
                        }),
                    Container(
                      child: Text(
                        (_descriptions[index % 45]),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ));

    //
    //
    //

    return Scaffold(
        appBar: GradientAppBar(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.purple[800], Colors.black]),
          actions: <Widget>[
            Container(
                width: 110,
                child: Image.asset('assets/jojo_text-removebg-preview.png')),
          ],
          title: Text(
            'Sound Board',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(alignment: AlignmentDirectional.center, children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/dio background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
              child: Text(
            'More Coming Soon!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50,
              color: Colors.grey,
            ),
          )),
          Container(
            child: listStuff,
          )
        ]));
  }

  void initSounds() async {
    audioPlayer = AudioPlayer();
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioCache.loadAll(_wows);
  }

  void stopSound(wow) {
    audioPlayer.stop();
  }

  void playSound(wow) async {
    var fileName = wow;
    if (audioPlayer.state == AudioPlayerState.PLAYING) {
      audioPlayer.stop();
    }
    audioPlayer = await audioCache.play(fileName);
  }
}
