import 'dart:async';
import 'package:beats/Models/Username.dart';
import 'package:beats/models/PlaylistRepo.dart';
import 'package:beats/models/BookmarkModel.dart';
import 'package:beats/models/Now_Playing.dart';
import 'package:flutter_media_notification/flutter_media_notification.dart';
import 'models/RecentsModel.dart';
import 'models/SongsModel.dart';
import 'package:provider/provider.dart';
import 'package:beats/screens/onboarding/Onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/MainScreen.dart';
import 'models/ThemeModel.dart';
import 'package:beats/models/ProgressModel.dart';

void main(List<String> args) {
  var prov = ProgressModel();
  var rec = Recents();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<BookmarkModel>(
      builder: (context) => BookmarkModel(),
    ),
    ChangeNotifierProvider<PlaylistRepo>(
      builder: (context) => PlaylistRepo(),
    ),
    ChangeNotifierProvider<Username>(
      builder: (context) => Username(),
    ),
    ChangeNotifierProvider<Recents>(
      builder: (context) => rec,
    ),
    ChangeNotifierProvider<ProgressModel>(
      builder: (context) => prov,
    ),
    ChangeNotifierProvider<SongsModel>(
      builder: (context) => SongsModel(prov, rec),
    ),
    ChangeNotifierProvider<ThemeChanger>(builder: (context) => ThemeChanger()),
    ChangeNotifierProvider<NowPlaying>(builder: (context) => NowPlaying(false))
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SongsModel model;

  @override
  void initState() {
    MediaNotification.setListener('pause', () {
      setState((){
        model.pause();
      });
    });

    MediaNotification.setListener('next', () {
      setState(() {
        model.player.stop();
        model.next();
        model.play();
      });
    });

    MediaNotification.setListener('prev', () {
      setState((){
        model.player.stop();
        model.previous();
        model.play();
      });
    });

    MediaNotification.setListener('play', () {
      setState(() => model.play());
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    model.stop();
  }

  @override
  Widget build(BuildContext context) {
    model = Provider.of<SongsModel>(context);
    ThemeChanger theme = Provider.of<ThemeChanger>(context);
    return new MaterialApp(
      home: new Splash(),
      theme: theme.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      SystemChrome.setEnabledSystemUIOverlays([]);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new MainScreen()));
    } else {
      SystemChrome.setEnabledSystemUIOverlays([]);
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnBoarding()));
    }
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.initState();
    checkFirstSeen();
  }
}
