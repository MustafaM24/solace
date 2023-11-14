import 'package:flutter/material.dart';
import 'package:solace/theme/color_scheme.dart';

AppBar myAppBar() {
  return AppBar(
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.white,
    title: RichText(
        text: const TextSpan(children: [
      TextSpan(
          text: 'Sol',
          style: TextStyle(
              color: PrimaryColor, fontSize: 30, fontFamily: 'Raleway')),
      TextSpan(
          text: 'ace',
          style: TextStyle(
              color: PrimaryFont, fontSize: 30, fontFamily: 'Raleway-Medium'))
    ])),
  );
}
