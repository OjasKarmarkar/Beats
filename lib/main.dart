import 'dart:async';

import 'models/SongsModel.dart';
import 'package:provider/provider.dart';

import 'package:beats/screens/onboarding/Onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/MainScreen.dart';
import 'models/ThemeModel.dart';
import 'package:beats/themes/Themes.dart';
import 'package:beats/models/ProgressModel.dart';

void main(List<String> args) {
  var prov = ProgressModel();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ProgressModel>(builder: (context)=>prov,),
        ChangeNotifierProvider<SongsModel>(builder: (context) => SongsModel(prov),),
        ChangeNotifierProvider<ThemeChanger>(builder: (context) => ThemeChanger(lightTheme()))
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    super.initState();
    checkFirstSeen();
  }
}
