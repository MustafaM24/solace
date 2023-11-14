import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Starter/LoginRegister/clipper_rect.dart';

import 'package:solace/backend/states.dart';
import 'package:solace/theme/color_scheme.dart';

class LoginCover extends StatelessWidget {
  const LoginCover({
    Key? key,
    required this.size,
    required this.login,
  }) : super(key: key);

  final Size size;
  final bool login;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ClipPath(
        clipper: Customshape(),
        child: AnimatedContainer(
          curve: Curves.easeIn,
          height: login ? size.height * 0.4 : size.height * 0.3,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  PrimaryColor,
                  PrimaryColor,
                  PrimaryColor,
                  gradColor,
                  SecondaryColor
                ]),
          ),
          duration: const Duration(seconds: 1),
        ),
      ),
      Positioned(
          top: size.height * 0.015,
          child: IconButton(
              iconSize: size.height * 0.04,
              onPressed: () {
                Provider.of<StateController>(context, listen: false)
                    .incrementSeq(0);
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ))),
      Positioned(
        top: login ? size.height * 0.14 : size.height * 0.06,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: size.height * 0.15,
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your Rescue,',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: CustTextStyle(fontRegular)
                        .copyWith(fontWeight: FontWeight.w400)),
                Text(
                  'Our Responsibility.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: CustTextStyle(fontMedium)
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        top: login ? size.height * 0.35 : size.height * 0.25,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(login ? 'Login' : 'Register',
                style: TextStyle(
                    color: PrimaryColor,
                    fontSize: size.height * 0.04,
                    fontFamily: fontBold)),
          ),
        ),
      ),
    ]);
  }

  // ignore: non_constant_identifier_names
  TextStyle CustTextStyle(String style) {
    return TextStyle(
      color: Colors.white,
      fontSize: size.height * 0.045,
      fontFamily: style,
    );
  }
}
