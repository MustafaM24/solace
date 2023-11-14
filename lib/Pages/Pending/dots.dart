import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Pages/Pending/pendingPage.dart';
import 'package:solace/backend/states.dart';

import 'package:solace/theme/color_scheme.dart';

class Dots extends StatelessWidget {
  const Dots({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final PendingPage widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: widget.width * 0.1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int i = 0; i < 3; i++)
            AnimatedContainer(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (Provider.of<StateController>(context)
                            .arrivalTime
                            .isEven |
                        Provider.of<StateController>(context).rideTime.isEven)
                    ? PrimaryColor
                    : Colors.white,
              ),
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
              width:
                  (Provider.of<StateController>(context).arrivalTime.isEven ||
                          Provider.of<StateController>(context).rideTime.isEven)
                      ? 10
                      : 0,
              height:
                  (Provider.of<StateController>(context).arrivalTime.isEven ||
                          Provider.of<StateController>(context).rideTime.isEven)
                      ? 10
                      : 0,
            ),
        ],
      ),
    );
  }
}
