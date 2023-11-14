import 'package:flutter/material.dart';

import 'package:solace/theme/color_scheme.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          button(),
          Text(
            ':',
            style: TextStyle(
                color: SecondaryFont.withOpacity(0.9),
                fontWeight: FontWeight.bold),
          ),
          button(),
          Container(
            width: size.width * 0.1,
            height:size.height * 0.040,
            decoration: BoxDecoration(
                color: SecondaryFont.withOpacity(0.1),
                borderRadius: BorderRadius.circular(size.width * 0.01),
                border: Border.all(
                  color: SecondaryFont.withOpacity(0.9),
                )),
            child: Column(
              children: [
                Container(
                    width: size.width * 0.1,
                    height: size.height * 0.020,
                    decoration: BoxDecoration(
                      color: PrimaryColor,
                      borderRadius: BorderRadius.circular(size.width * 0.01),
                    ),
                    child: const Center(
                        child: Text(
                      'AM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container button() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: size.width * 0.2,
        height: size.height * 0.040,
        decoration: BoxDecoration(
            color: SecondaryFont.withOpacity(0.1),
            borderRadius: BorderRadius.circular(size.width * 0.01),
            border: Border.all(
              color: SecondaryFont.withOpacity(0.9),
            )),
        child: const Center(
            child: Text(
          '12',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: SecondaryFont,
          ),
        )));
  }
}
