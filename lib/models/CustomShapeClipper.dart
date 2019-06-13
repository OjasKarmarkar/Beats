import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../screens/HomeScreen.dart' as util;

class CustomShapeClipper extends CustomClipper<Path>{
  @override
  getClip(Size size) {

   final Path path = new Path();

   
   path.lineTo(0 , util.height*0.45);
   var firstControlPoint =  Offset(size.width*0.13, util.height*0.4-25);
   var firstEndPoint = Offset(size.width*0.30, util.height*0.4-30);

   path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
   path.lineTo(util.width, util.height*0.45-60);
   path.lineTo(util.width, 0);
   
   path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
  
    return true;
  }

}