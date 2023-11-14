import 'package:flutter/material.dart';

import 'package:solace/Starter/IntialScreen/feature_list.dart';
import 'package:solace/Starter/IntialScreen/initial_screen_buttons.dart';
import 'package:solace/Starter/IntialScreen/logo_cover.dart';



// ignore: must_be_immutable
class InitialScreen extends StatelessWidget {
  InitialScreen({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;
  List<String> points = [
    'Book an emergency cab fast, easy & secure.',
    'Schedule an ambulance of your choice for a regular visit.',
    'Variety of ambulance available as per your choice.',
    'Well trained & Professional team.',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  size.width * 0.05, 0, size.width * 0.05, size.height * 0.05),
              child: Image.asset(
                'assets/stickers/Ambulance-pana.png',
                height: size.height * 0.3,
              ),
            ),
            Logo(size: size),
            featureList(size: size, points: points),
            InitialScreenButtonList(size: size, ctx: context)
          ],
        ),
      ),
    );
  }
}
