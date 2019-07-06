import 'package:flutter/material.dart';

darkTheme() {
  return ThemeData(
      cardColor: Colors.black12,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.black87,
      textTheme: TextTheme(
          display3: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
          display1: TextStyle(
              color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
          display2: TextStyle(
            letterSpacing: 1.1,
            fontFamily: 'sans-serif',
            fontSize: 17,
            color: Colors.white,
          ),
          subhead: TextStyle(
              letterSpacing: 1.2,
              fontFamily: 'sans-serif',
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w500),
          headline: TextStyle(
              fontFamily: 'sans-serif',
              color: Colors.white,
              fontSize: 45,
              fontWeight: FontWeight.bold)));
}
