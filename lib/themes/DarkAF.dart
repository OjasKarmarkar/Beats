import 'package:flutter/material.dart';

darkAFTheme() {
  return ThemeData(
    cardColor: Colors.black87,
      cardTheme: CardTheme(color: Colors.black87),
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
      textTheme: TextTheme(
          display3: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500),
          display1: TextStyle(
              color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.w400),
          headline: TextStyle(
              fontFamily: 'Sans',
              color: Colors.white,
              fontSize: 45,
              fontWeight: FontWeight.bold),
          subhead: TextStyle(
              letterSpacing: 1.1,
              fontFamily: 'Sans',
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w500),
          display2: TextStyle(
            fontFamily: 'Sans',
            letterSpacing: 1.1,
            fontSize: 17,
            color: Colors.white,
          )));
}
