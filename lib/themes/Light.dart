import 'package:flutter/material.dart';

lightTheme() {
  return ThemeData(
    cardTheme: CardTheme(color: Colors.white),
      textTheme: TextTheme(display1: TextStyle(color: Colors.black, fontSize: 22.0 , fontWeight: FontWeight.bold),
          display2: TextStyle(
                      fontFamily: 'sans-serif',
                      fontSize: 18,
                      color: Colors.black,
                      )),
      iconTheme: IconThemeData(
        color: Colors.grey
        ),
      backgroundColor: Colors.white);
}
