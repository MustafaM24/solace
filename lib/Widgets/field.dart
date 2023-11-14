import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:solace/backend/form_handler.dart';

import '../theme/color_scheme.dart';

class Field extends StatefulWidget {
  const Field({
    Key? key,
    required this.size,
    required this.label,
    required this.suggestion,
    required this.dark,
    required this.userType,
    required this.formType,
  }) : super(key: key);

  final bool dark;
  final Size size;
  final String label;
  final String suggestion;

  final String userType;
  final String formType;

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    myController.addListener(saveLatestValue);
  }

  void saveLatestValue() {
    if (widget.formType == 'login') {
      Provider.of<FormHandler>(context, listen: false)
          .loginRecord(widget.label, myController.text);
    } else {
      if (widget.formType == 'register') {
        Provider.of<FormHandler>(context, listen: false)
            .setRegData(widget.label, myController.text);
      } else if (widget.formType == 'emergency') {
        Provider.of<FormHandler>(context, listen: false)
            .emergencyRecord(widget.label, myController.text);
      } else if (widget.formType == 'schedule') {
        Provider.of<FormHandler>(context, listen: false)
            .scheduleRecord(widget.label, myController.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.label,
            style: const TextStyle(
                color: PrimaryColor,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: fontMedium),
          ),
        ),
        Container(
          width: widget.size.width * 0.8,
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            keyboardType: widget.label == 'Phone'
                ? TextInputType.phone
                : TextInputType.text,
            autofocus: true,
            maxLength: widget.label == 'Password'
                ? 8
                : widget.label == 'Phone'
                    ? 11
                    : widget.label == 'User Name'
                        ? 5
                        : widget.label == 'Ambulance Number'
                            ? 8
                            : null,
            controller: myController,
            textCapitalization: widget.label == 'Ambulance Number'
                ? TextCapitalization.characters
                : TextCapitalization.none,
            obscureText: widget.label == 'Password' ? true : false,
            cursorColor: widget.dark ? Colors.white : SecondaryFont,
            cursorHeight: 25,

            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: SecondaryFont)),
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: SecondaryFont)),
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: widget.dark ? Colors.white : PrimaryColor)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: SecondaryFont)),
              labelStyle: const TextStyle(color: SecondaryFont, fontSize: 14),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              floatingLabelStyle:
                  const TextStyle(color: SecondaryFont, fontFamily: fontMedium),
              label: Text(widget.suggestion),
            ),
            // The validator receives the text that the user has entered.
            validator: validationMethod,
          ),
        ),
      ],
    );
  }

  String? validationMethod(value) {
    if (widget.label == 'Phone') {
      String patttern = r'(^(?:[0]3)?[0-9]{11}$)';
      RegExp regExp = RegExp(patttern);
      if (value == null) {
        return 'Please enter mobile number';
      } else if (!regExp.hasMatch(value)) {
        return 'Please enter valid mobile number';
      }
    } else if (widget.label == 'Email') {
      String patttern = r"[a-z]|[1-9]{1,2}";
      RegExp regExp = RegExp(patttern);
      if (value == null) {
        return 'Please enter your email';
      } else if (!regExp.hasMatch(value)) {
        return 'Please enter a valid email (i.e xxx.usertype@solace.com)';
      }
    } else if (widget.label == 'Ambulance Number') {
      String patttern = r"[A-Z]{1,3}-[0-9]{1,4}";
      RegExp regExp = RegExp(patttern);
      if (value == null) {
        return 'Please enter your vehicle registration number.';
      } else if (!regExp.hasMatch(value)) {
        return 'Please enter a valid vehicle registration number.';
      }
    } else if (value == null || value.isEmpty) {
      if (widget.label == 'Name') {
        return 'Please enter correct name';
      } else {
        return 'Please enter correct location';
      }
    }
    return null;
  }
}
