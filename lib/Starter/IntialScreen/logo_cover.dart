import 'package:flutter/material.dart';
import 'package:solace/theme/color_scheme.dart';




class Logo extends StatelessWidget {
  const Logo({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
          text: 'Sol',
          style: TextStyle(
              color: PrimaryColor,
              fontSize: size.height * 0.08,
              fontFamily: 'Raleway')),
      TextSpan(
          text: 'ace',
          style: TextStyle(
              color: PrimaryFont,
              fontSize: size.height * 0.08,
              fontFamily: 'Raleway-Medium'))
    ]));
  }
}
