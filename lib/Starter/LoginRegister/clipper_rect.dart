import 'package:flutter/material.dart';

class Customshape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height * 0.8;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height);
    path.lineTo(width * 0.8, height);
    path.quadraticBezierTo(width * 0.95, height, width, height * 1.2);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
