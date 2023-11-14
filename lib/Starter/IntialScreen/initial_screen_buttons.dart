import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/backend/states.dart';
import 'package:solace/theme/color_scheme.dart';

class InitialScreenButtonList extends StatelessWidget {
  const InitialScreenButtonList(
      {Key? key, required this.size, required this.ctx})
      : super(key: key);
  final BuildContext ctx;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (() {
            Provider.of<StateController>(ctx, listen: false).incrementSeq(1);
          }),
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                  color: SecondaryFont.withOpacity(0.4))
            ], color: PrimaryColor, borderRadius: BorderRadius.circular(5)),
            height: size.height * 0.06,
            width: size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Login',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: size.height * 0.02,
                        fontFamily: 'Raleway-Medium')),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Provider.of<StateController>(ctx, listen: false).incrementSeq(2);
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                      color: SecondaryFont.withOpacity(0.4))
                ],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: PrimaryColor, width: 2)),
            height: size.height * 0.06,
            width: size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Register',
                    style: TextStyle(
                        color: PrimaryColor,
                        fontSize: size.height * 0.02,
                        fontFamily: 'Raleway-Medium')),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
