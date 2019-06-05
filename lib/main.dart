import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './Screens/Home.dart';

void main(List<String> args) {
  
  SystemChrome.setEnabledSystemUIOverlays([]);
  
  runApp(
    new MaterialApp(
    
     home: new Home(),
     debugShowCheckedModeBanner: false,

    )
  );

}