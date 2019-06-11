import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 220,
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 130.0, left: 40),
                      child: Text("User,",
                          style: TextStyle(
                              fontFamily: 'sans-serif',
                              fontSize: 45,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 40),
                      child: Text("Welcome",
                          style: TextStyle(
                              letterSpacing: 1.2,
                              fontFamily: 'sans-serif',
                              fontSize: 30,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
