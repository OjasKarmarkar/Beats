import 'package:flutter/material.dart';

darkTheme() {
  return ThemeData(
  
   cardColor: Colors.black12,
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Colors.black,
      textTheme:
          TextTheme(display1: TextStyle(color: Colors.white, fontSize: 25.0 , fontWeight: FontWeight.bold),
          display2: TextStyle(
                      fontFamily: 'sans-serif',
                      fontSize: 18,
                      color: Colors.white,
                      )
          ));
          
}
