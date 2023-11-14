import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solace/Driver/current_booking_tile.dart';
import 'package:solace/theme/color_scheme.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key, required this.size});
  final Size size;

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _scheduleStream = FirebaseFirestore.instance
      .collection('solace')
      .doc('bookings')
      .collection('bookings')
      .where('Status', isEqualTo: 'Requested')
      .snapshots();

  final Stream<QuerySnapshot> _acceptedStream = FirebaseFirestore.instance
      .collection('solace')
      .doc('bookings')
      .collection('bookings')
      .where('Status', isEqualTo: 'Accepted')
      .where('Driver ID',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size.height * 0.8,
      width: widget.size.width * 0.95,
      padding: EdgeInsets.all(widget.size.width * 0.02),
      child: ListView(
        children: [
          ExpandablePanel(
            theme: const ExpandableThemeData(iconColor: PrimaryColor),
            expanded: SizedBox(
              height: widget.size.height * 0.6,
              child: StreamBuilder<QuerySnapshot>(
                stream: _scheduleStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return CurrentBookingsTile(
                            size: widget.size,
                            data: data,
                            docId: document.id,
                          );
                        })
                        .toList()
                        .cast(),
                  );
                },
              ),
            ),
            collapsed: Container(),
            header: Card(
              color: PrimaryColor,
              child: Padding(
                padding: EdgeInsets.all(widget.size.width * 0.02),
                child: Text(
                  'Incoming new rides',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Raleway',
                      fontSize: widget.size.height * 0.02),
                ),
              ),
            ),
          ),
          SizedBox(
            height: widget.size.height * 0.02,
          ),
          ExpandablePanel(
            theme: const ExpandableThemeData(iconColor: PrimaryColor),
            expanded: SizedBox(
              height: widget.size.height * 0.7,
              child: StreamBuilder<QuerySnapshot>(
                stream: _acceptedStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return CurrentBookingsTile(
                            size: widget.size,
                            data: data,
                            docId: document.id,
                          );
                        })
                        .toList()
                        .cast(),
                  );
                },
              ),
            ),
            collapsed: Container(),
            header: Card(
              color: PrimaryColor,
              child: Padding(
                padding: EdgeInsets.all(widget.size.width * 0.02),
                child: Text(
                  'Your Registered',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Raleway',
                      fontSize: widget.size.height * 0.02),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
