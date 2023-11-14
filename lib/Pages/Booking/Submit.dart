// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/backend/Futures/booking_request.dart';
import 'package:solace/backend/form_handler.dart';
import 'package:solace/backend/states.dart';
import 'package:solace/theme/color_scheme.dart';

class SubmitButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  const SubmitButton(
      {Key? key,
      required this.label,
      required this.size,
      required this.formKey,
      required this.dark,
      required this.submitType})
      : super(key: key);
  final bool dark;
  final Size size;
  final String label;
  final String submitType;

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.fromLTRB(0, widget.size.height * 0.04, 0, 0),
      child: SizedBox(
        width: widget.size.width * 0.75,
        height: widget.size.height * 0.06,
        child: CustButton(
          widget: widget,
          submitType: widget.submitType,
        ),
      ),
    );
  }
}

class CustButton extends StatelessWidget {
  const CustButton({
    Key? key,
    required this.widget,
    required this.submitType,
  }) : super(key: key);

  final SubmitButton widget;
  final String submitType;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: custButtonStyle(),
      onPressed: () {
        // Validate returns true if the form is valid, or false otherwise.
        if (widget.formKey.currentState!.validate()) {
          String user = FirebaseAuth.instance.currentUser!.uid;
          if (submitType == 'emergencyBookings') {
            Provider.of<FormHandler>(context, listen: false).emergencyRecord(
                'Accident type',
                Provider.of<StateController>(context, listen: false)
                    .getAccident());
            Provider.of<FormHandler>(context, listen: false)
                .emergencyRecord('User ID', user);
          } else {
            Provider.of<FormHandler>(context, listen: false)
                .scheduleRecord('User ID', user);
            Provider.of<FormHandler>(context, listen: false).scheduleRecord(
                'Ambulance type',
                Provider.of<StateController>(context, listen: false)
                    .getAmbulance());
          }

          sendData(context, submitType);
        }
      },
      child: Text(
        widget.label,
        style: const TextStyle(
            color: Colors.white, fontSize: 16, fontFamily: 'Raleway-Medium'),
      ),
    );
  }

  ButtonStyle custButtonStyle() {
    return ButtonStyle(
      elevation: MaterialStateProperty.resolveWith((states) => 5),
      backgroundColor: MaterialStateProperty.resolveWith((states) {
        // If the button is pressed, return green, otherwise blue
        if (states.contains(MaterialState.pressed)) {
          return PrimaryColor.withOpacity(0.8);
        } else {
          return PrimaryColor;
        }
      }),
    );
  }
}
