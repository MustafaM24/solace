// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Pages/Pending/pendingPage.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:solace/theme/color_scheme.dart';
import '../../backend/states.dart';

class Call extends StatelessWidget {
  const Call({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final PendingPage widget;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width * 0.6,
      height: widget.width * 0.16,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: ElevatedButton(
          onPressed: () {
            String num = Provider.of<StateController>(context, listen: false)
                .ambulanceInformation[5];
            _callNumber(num);
            //  Provider.of<form_state>(context, listen: false).increment();
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              // If the button is pressed, return green, otherwise blue
              if (states.contains(MaterialState.pressed)) {
                return PrimaryColor.withOpacity(0.5);
              }
              return PrimaryColor;
            }),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Icon(
                  Icons.phone,
                ),
              ),
              Text(
                'Call Ambulance',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Sans'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _callNumber(String num) async {
    //set the number here
    await FlutterPhoneDirectCaller.callNumber(num);
  }
}
