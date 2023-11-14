// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Pages/Pending/Call.dart';
import 'package:solace/Pages/Pending/dots.dart';
import 'package:solace/Pages/Pending/table.dart';
import 'package:solace/backend/states.dart';
import 'package:solace/theme/color_scheme.dart';

class PendingPage extends StatefulWidget {
  const PendingPage({super.key, required this.width, required this.height});
  final double width;
  final double height;
  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  Future<Map<String, String>> getData() async {
    Map<String, String> driverData = {};

    FirebaseFirestore.instance
        .collection('solace')
        .doc('bookings')
        .collection('bookings')
        .doc(Provider.of<StateController>(context).CurrentDoc)
        .get()
        .then((value) {
      value.data()!.forEach((key, value) {
        driverData[key] = value;
      });
    });
    await Future.delayed(Duration(seconds: 4), () {});
    return driverData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(builder: (ctx, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              '${snapshot.error} occurred',
              style: TextStyle(fontSize: 18),
            ),
          );

          // if we got our data
        } else if (snapshot.hasData) {
          // Extracting data from snapshot object
          final data = snapshot.data as String;
          return WhenDone(context);
        }
      }
      return Container(
          height: widget.height * 0.05,
          width: widget.height * 0.05,
          child: CircularProgressIndicator());
    });
  }

  SingleChildScrollView WhenDone(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Provider.of<StateController>(context).ride == false
            ? Column(
                children: [
                  const Text(
                    'Rescue incoming',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/Icons/heart-beat.gif',
                    ),
                  ),
                  Text(
                    '${Duration(seconds: Provider.of<StateController>(context).arrivalTime).inMinutes} min ${Duration(seconds: Provider.of<StateController>(context).arrivalTime).inSeconds}s',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const TableInformation(),
                  Call(widget: widget)
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.pin_drop, color: PrimaryColor, size: 30),
                      Text(
                        'Going towards ${Provider.of<StateController>(context).ambulanceInformation[3]}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      'assets/Icons/ambulance.gif',
                    ),
                  ),
                  Text(
                    '${Duration(seconds: Provider.of<StateController>(context).rideTime).inMinutes} min ${Duration(seconds: Provider.of<StateController>(context).rideTime).inSeconds}s',
                    style: const TextStyle(fontSize: 20),
                  ),
                  Dots(widget: widget),
                  Card(
                    borderOnForeground: false,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 2, color: SecondaryFont.withOpacity(0.2)),
                          borderRadius: BorderRadius.circular(10)),
                      height:
                          Provider.of<StateController>(context).ride == false
                              ? widget.height * 0.35
                              : widget.height * 0.4,
                      width: widget.width * 0.8,
                      child: const SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: TableInformation(),
                      ),
                    ),
                  ),
                ],
              ));
  }
}
