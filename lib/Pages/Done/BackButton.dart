// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/backend/states.dart';
import 'package:solace/theme/color_scheme.dart';

class CustomBackButton extends StatefulWidget {
  const CustomBackButton({Key? key, required this.width}) : super(key: key);

  final double width;

  @override
  State<CustomBackButton> createState() => _CustomBackButtonState();
}

class _CustomBackButtonState extends State<CustomBackButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: SizedBox(
        width: widget.width * 0.6,
        height: 50,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              // If the button is pressed, return green, otherwise blue
              if (states.contains(MaterialState.pressed)) {
                return PrimaryColor.withOpacity(0.5);
              }
              return PrimaryColor;
            }),
          ),
          onPressed: () {
            Provider.of<StateController>(context, listen: false)
                .incrementFormState();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.arrow_back),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, widget.width * 0.15, 0),
                child: const Text(
                  'Book again',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'Sans'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
