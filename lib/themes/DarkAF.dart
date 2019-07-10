import 'package:flutter/material.dart';

darkAFTheme() {
  return ThemeData(
      cardColor: Colors.black12,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
      textTheme: TextTheme(
          display3: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
          display1: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
          headline: TextStyle(
              fontFamily: 'sans-serif',
              color: Colors.white,
              fontSize: 45,
              fontWeight: FontWeight.bold),
          subhead: TextStyle(
              letterSpacing: 1.1,
              fontFamily: 'sans-serif',
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w500),
          display2: TextStyle(
            fontFamily: 'sans-serif',
            letterSpacing: 1.1,
            fontSize: 17,
            color: Colors.white,
          )));
}
