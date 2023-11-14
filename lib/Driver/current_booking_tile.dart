import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:solace/theme/color_scheme.dart';

class CurrentBookingsTile extends StatelessWidget {
  const CurrentBookingsTile(
      {Key? key, required this.size, required this.data, required this.docId})
      : super(key: key);
  final String docId;
  final Size size;
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Card(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(size.width * 0.03),
          child: data['Status'] == 'Accepted'
              ? Row(children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                    height: size.height * 0.012,
                    width: size.height * 0.012,
                    decoration: BoxDecoration(
                      color: colorState(),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 5,
                        )
                      ],
                      border: Border.all(color: SecondaryFont.withOpacity(0.2)),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Text(
                    data['Status']!,
                    style: textStyle(FontWeight.bold, 'Raleway-Medium'),
                  )
                ])
              : data['form-type'] == 'Emergency'
                  ? Row(
                      children: [
                        Text(
                          data['Accident type']!,
                          style: textStyle(
                            FontWeight.w800,
                            'Raleway-Medium',
                          ).copyWith(color: PrimaryColor),
                        ),
                      ],
                    )
                  : Text(
                      'Scheduled',
                      style: textStyle(
                        FontWeight.w800,
                        'Raleway-Medium',
                      ),
                    ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: SecondaryFont.withOpacity(0.2), width: 2))),
          margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05, vertical: size.height * 0.01),
          height: size.height * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        'Ride ID: ',
                        style: textStyle(FontWeight.w800, 'Raleway-Medium'),
                      ),
                      Text(
                        docId.substring(0, 5),
                        style: textStyle(FontWeight.normal, 'Raleway-Medium'),
                      ),
                    ],
                  ),
                  (data['form-type'] == 'Emergency' &&
                          data['Status'] == 'Accepted')
                      ? Row(
                          children: [
                            Text(
                              'Patient Condition: ',
                              style:
                                  textStyle(FontWeight.w800, 'Raleway-Medium'),
                            ),
                            Text(
                              data['Accident type']!,
                              style: textStyle(
                                  FontWeight.normal, 'Raleway-Medium'),
                            ),
                          ],
                        )
                      : Container(),
                  Row(
                    children: [
                      Text(
                        'Pickup location: ',
                        style: textStyle(FontWeight.w800, 'Raleway-Medium'),
                      ),
                      Text(
                        data['Pickup location']!,
                        style: textStyle(FontWeight.normal, 'Raleway-Medium'),
                      ),
                    ],
                  ),
                  data['form-type'] == 'Schedule'
                      ? Row(
                          children: [
                            Text(
                              'Time: ',
                              style:
                                  textStyle(FontWeight.w800, 'Raleway-Medium'),
                            ),
                            Text(
                              data['Time']!,
                              style: textStyle(
                                  FontWeight.normal, 'Raleway-Medium'),
                            ),
                          ],
                        )
                      : Container(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    width: size.width * 0.7,
                    child: data['Status'] == 'Accepted'
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  String nmbr = '';
                                  await FirebaseFirestore.instance
                                      .collection('solace')
                                      .doc('users')
                                      .collection('regularUser')
                                      .doc(data['User ID'])
                                      .get()
                                      .then((value) {
                                    nmbr = value.data()!['Phone'];
                                    FlutterPhoneDirectCaller.callNumber(nmbr);
                                  });
                                  FlutterPhoneDirectCaller.callNumber(nmbr);
                                },
                                style: custButtonStyle(),
                                child: const Text('Contact'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  showAlertDialogStart(context);
                                },
                                style: custButtonStyle(),
                                child: const Text('Start Ride'),
                              ),
                            ],
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.15),
                            child: ElevatedButton(
                              onPressed: () async {
                                showAlertDialogAccepted(context);
                                await FirebaseFirestore.instance
                                    .collection('solace')
                                    .doc('bookings')
                                    .collection('bookings')
                                    .doc(docId)
                                    .update({
                                  'Status': 'Accepted',
                                  'Driver ID': user!.uid.toString()
                                });
                              },
                              style: custButtonStyle(),
                              child: const Text('Accept'),
                            ),
                          ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Color colorState() {
    if (data['Status'] == 'Requested') {
      return const Color.fromARGB(255, 255, 230, 4);
    } else {
      return data['Status'] == 'Ongoing'
          ? PrimaryColor
          : const Color.fromARGB(255, 0, 255, 17);
    }
  }

  TextStyle textStyle(
    FontWeight fw,
    String family,
  ) {
    return TextStyle(
        fontWeight: fw, fontFamily: family, fontSize: size.height * 0.015);
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

showAlertDialogAccepted(
  BuildContext context,
) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Icon(
      Icons.done_rounded,
      color: Colors.greenAccent,
      size: 50,
    ),
    content: Container(
      height: 40,
      child: Center(
          child: Text(
        'Ride has been accepted',
        style: TextStyle(fontFamily: 'Raleway', fontSize: 20),
      )),
    ),
    actions: [],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogStart(
  BuildContext context,
) {
  // set up the button

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: SizedBox(
      height: 100,
      width: 100,
      child: Image.asset(
        'assets/Icons/ambulance.gif',
      ),
    ),
    content: Container(
      height: 40,
      child: Center(
          child: Text(
        'Ride has started now!',
        style: TextStyle(fontFamily: 'Raleway', fontSize: 20),
      )),
    ),
    actions: [],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
