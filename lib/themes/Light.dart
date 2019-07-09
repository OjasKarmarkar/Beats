import 'package:flutter/material.dart';

lightTheme() {
  return ThemeData(
      cardTheme: CardTheme(color: Colors.white),
      textTheme: TextTheme(
          display3: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.w600),
          display1: TextStyle(
              color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.bold),
          headline: TextStyle(
              fontFamily: 'sans-serif',
              color: Colors.black,
              fontSize: 45,
              fontWeight: FontWeight.bold),
          subhead: TextStyle(
              letterSpacing: 1.2,
              fontFamily: 'sans-serif',
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.w500),
          display2: TextStyle(
            fontFamily: 'sans-serif',
            letterSpacing: 1.1,
            fontSize: 17,
            color: Colors.black,
          )),
      iconTheme: IconThemeData(color: Colors.grey),
      backgroundColor: Colors.white);
}
