// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:solace/Pages/Done/BackButton.dart';

import 'package:solace/theme/color_scheme.dart';

class Done extends StatelessWidget {
  final double width;
  final double height;
  const Done({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
            child: SizedBox(
              height: 150,
              width: 150,
              child: Image.asset(
                'assets/Icons/handshake.gif',
              ),
            ),
          ),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Glad to help you!',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          const BookingData(),

          CustomBackButton(
            width: width,
          )
        ],
      ),
    );
  }
}

class BookingData extends StatelessWidget {
  const BookingData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(70, 40, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.pin_drop, color: PrimaryColor, size: 30),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text('13 D3 Gulshan-e-Iqbal, Karachi.'),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < 4; i++)
                  Container(
                    margin: const EdgeInsets.all(3),
                    height: 5,
                    width: 5,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: PrimaryColor),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Icon(Icons.pin_drop, color: PrimaryColor, size: 30),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text('rgfrgdfg'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
