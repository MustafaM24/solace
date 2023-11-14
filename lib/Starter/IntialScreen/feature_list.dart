import 'package:flutter/material.dart';
import 'package:solace/theme/color_scheme.dart';

// ignore: camel_case_types
class featureList extends StatelessWidget {
  const featureList({
    Key? key,
    required this.size,
    required this.points,
  }) : super(key: key);

  final Size size;
  final List<String> points;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < 4; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.01),
                    child: const Icon(
                      Icons.check,
                      color: PrimaryColor,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.8,
                    child: Text(points[i],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: PrimaryFont,
                            fontSize: size.height * 0.015,
                            fontFamily: 'Raleway-Medium')),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
