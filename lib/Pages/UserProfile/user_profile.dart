import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Pages/UserProfile/logout.dart';
import 'package:solace/Pages/UserProfile/profile_cover.dart';
import 'package:solace/backend/states.dart';

import 'package:solace/theme/color_scheme.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.sz});
  final Size sz;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Future<Map<String, String>> addUserData() async {
    Map<String, String> userdata = {};

    User? user = FirebaseAuth.instance.currentUser;
    await FirebaseFirestore.instance
        .collection('solace')
        .doc('users')
        .collection(
            user!.email.toString().contains('user') ? 'regularUser' : 'driver')
        .doc(user.uid.toString())
        .get()
        .then((value) {
      value.data()!.forEach((key, value) async {
        userdata[key] = value;
      });
    });
    return userdata;
  }

  final List<String> fields = ['Phone', 'Email', 'Ride Count'];
  final List<IconData> icons = [
    Icons.phone_android,
    Icons.alternate_email_outlined,
    Icons.commute_outlined
  ];
  @override
  void initState() {
    addUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.sz.height * 0.85,
      child: ListView(
        children: [
          Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                (Provider.of<StateController>(context, listen: false)
                        .profileInformation
                        .isNotEmpty)
                    ? Container(
                        height: widget.sz.height * 0.4,
                      )
                    : FutureBuilder<Map<String, String>>(
                        future: addUserData(),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return SizedBox(
                                height: widget.sz.height * 0.7,
                                child: Column(
                                  children: [
                                    ProfilePicture(
                                        sz: widget.sz,
                                        name: snapshot.data!['Name'] as String),
                                    Card(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Column(
                                        children: [
                                          for (int i = 0;
                                              i < fields.length;
                                              i++)
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      widget.sz.width * 0.1,
                                                  vertical:
                                                      widget.sz.height * 0.01),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    icons[i],
                                                    size:
                                                        widget.sz.width * 0.06,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        widget.sz.width * 0.02,
                                                  ),
                                                  Text(
                                                    snapshot.data![fields[i]]
                                                        as String,
                                                    style: TextStyle(
                                                        fontSize:
                                                            widget.sz.height *
                                                                0.02,
                                                        fontFamily:
                                                            'Raleway-Medium'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                          } else if (snapshot.hasError) {
                            const Text('no data');
                          }
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: widget.sz.height * 0.15),
                            child: SizedBox(
                              height: widget.sz.height * 0.1,
                              width: widget.sz.height * 0.1,
                              child: const CircularProgressIndicator(
                                color: PrimaryColor,
                              ),
                            ),
                          );
                        },
                      ),
                LogOut(sz: widget.sz)
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names

}

class Circle extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;

    var path = Path();
    path.addArc(
        Rect.fromCircle(center: Offset.zero, radius: height / 1.5), 0, 2 * pi);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
