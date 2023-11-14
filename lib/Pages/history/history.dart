import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solace/Pages/history/history_card.dart';
import 'package:solace/theme/color_scheme.dart';

class History extends StatefulWidget {
  const History({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final Stream<QuerySnapshot> _historyStream = FirebaseFirestore.instance
      .collection('solace')
      .doc('bookings')
      .collection('bookings')
      .where('User ID',
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
                  child: const Text('History',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'Raleway',
                        color: Colors.black54,
                      ))),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _historyStream,
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
                          return HistoryRecord(size: widget.size, data: data, docID: document.id,);
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
