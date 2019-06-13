import 'dart:async';

import 'package:beats/onboarding/Onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './screens/MainScreen.dart';

void main(List<String> args) {
  
  SystemChrome.setEnabledSystemUIOverlays([]);
  
  runApp(
    new MaterialApp(
    
     home: new Splash(),
     debugShowCheckedModeBanner: false,

    )
  );

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
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new MainScreen()));
    } else {
    prefs.setBool('seen', true);
    Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new OnBoarding()));
    }
}

@override
void initState() {
    super.initState();
    new Timer(new Duration(milliseconds: 200), () {
    checkFirstSeen();
    });
}
}
  