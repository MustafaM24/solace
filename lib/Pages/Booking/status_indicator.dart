import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../backend/states.dart';
import '../../theme/color_scheme.dart';

class StatusIndictor extends StatefulWidget {
  const StatusIndictor({Key? key}) : super(key: key);

  @override
  State<StatusIndictor> createState() => _StatusIndictorState();
}

class _StatusIndictorState extends State<StatusIndictor> {
  @override
  Widget build(BuildContext context) {
    Row row(int i) {
      return Row(
        children: [line(context, i, true), line(context, i, false)],
      );
    }

    return Column(
      children: [
        // Text of the status bar
        Container(
          width: 400,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 2; i++)
                Row(
                  children: [
                    Text(
                      i == 0 ? 'Book' : 'Pending',
                      style: TextStyle(
                          fontFamily: Provider.of<StateController>(context)
                                      .bookingState ==
                                  i
                              ? 'Raleway'
                              : 'Raleway-Regular',
                          color: Provider.of<StateController>(context)
                                      .bookingState ==
                                  i
                              ? PrimaryFont
                              : SecondaryFont),
                    ),
                  ],
                ),
              Text(
                'Finished',
                style: TextStyle(
                    fontFamily: 'Raleway-Regular',
                    color:
                        Provider.of<StateController>(context).bookingState == 2
                            ? PrimaryFont
                            : SecondaryFont),
              ),
            ],
          ),
        ),

        // Line of the status bar
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 2; i++) row(i),
            line(context, 2, true)
          ],
        ),
      ],
    );
  }

  AnimatedContainer line(BuildContext context, int i, bool circle) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        // Provide an optional curve to make the animation feel smoother.
        curve: Curves.fastOutSlowIn,
        height: circle ? 15 : 5,
        width: circle ? 15 : 100,
        decoration: Provider.of<StateController>(context).bookingState == i
            ? BoxDecoration(
                shape: circle ? BoxShape.circle : BoxShape.rectangle,
                boxShadow: [
                  boxshadow(),
                ],
                border: circle
                    ? Border.all(
                        width: 3,
                        color: PrimaryColor,
                      )
                    : Border.all(color: PrimaryColor),
                color: circle ? const Color(0xffFAF9F6) : PrimaryColor)
            : BoxDecoration(
                shape: circle ? BoxShape.circle : BoxShape.rectangle,
                color: SecondaryFont.withOpacity(0.30),
              ));
  }

  BoxShadow boxshadow() {
    return const BoxShadow(
      color: Colors.black26,
      blurRadius: 2.0,
      spreadRadius: 0.0,
      offset: Offset(2.0, 2.0), // shadow direction: bottom right
    );
  }
}
