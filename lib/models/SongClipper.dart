import 'package:beats/screens/HomeScreen.dart' as util;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SongClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {

   final Path path = new Path();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
