import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solace/Driver/driver_history/driver_history_record.dart';
import 'package:solace/theme/color_scheme.dart';

class DriverHistory extends StatefulWidget {
  const DriverHistory({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<DriverHistory> createState() => _DriverHistoryState();
}

class _DriverHistoryState extends State<DriverHistory> {
  final Stream<QuerySnapshot> _DriverHistoryStream = FirebaseFirestore.instance
      .collection('solace')
      .doc('bookings')
      .collection('bookings')
      .where('Status', isEqualTo: 'Done')
      .where('Driver ID',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(widget.size.height * 0.02),
              child: Title(
                  color: PrimaryFont,
                  child: const Text('DriverHistory',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Raleway',
                        color: Colors.black54,
                      ))),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _DriverHistoryStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                return SizedBox(
                  height: widget.size.height * 0.7,
                  child: ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return DriverHistoryRecord(
                            size: widget.size,
                            data: data,
                            docID: document.id,
                          );
                        })
                        .toList()
                        .cast(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
