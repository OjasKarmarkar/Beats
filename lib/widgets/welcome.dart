import 'package:flutter/material.dart';

getWelcome(var height1,var width){
  return Container(
    height: height1*0.25,
    child: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: height1*0.1, left: width*0.1),
              child: Text("User,",
                  style: TextStyle(
                      fontFamily: 'sans-serif',
                      fontSize: 45,
                      fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: width*0.1),
              child: Text("Welcome",
                  style: TextStyle(
                      letterSpacing: 1.2,
                      fontFamily: 'sans-serif',
                      fontSize: 30,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        Align(alignment: Alignment.topRight,child:Image.asset("assets/headphone.png"))
      ],
    ),
  );
}