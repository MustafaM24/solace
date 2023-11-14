import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:solace/theme/color_scheme.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({
    Key? key,
    required this.sz,
    required this.name,
  }) : super(key: key);

  final Size sz;
  final String name;

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  Future<String> getPicture() async {
    User? user = FirebaseAuth.instance.currentUser;
    String downloadURL = '';
    downloadURL = await FirebaseStorage.instance
        .ref('profile_pictures')
        .child(user!.uid.toString())
        .getDownloadURL();
    return downloadURL;
  }

  @override
  void initState() {
    getPicture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: widget.sz.height * 0.3,
        ),
        Container(
          height: widget.sz.height * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: PrimaryColor,
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 20,
                    spreadRadius: 1,
                    color: SecondaryFont)
              ]),
        ),
        FutureBuilder<String>(
            future: getPicture(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.all(0),
                        width: widget.sz.width * 0.3,
                        height: widget.sz.height * 0.3,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(snapshot.data!)),
                            border: Border.all(
                              color: PrimaryColor,
                              width: 5,
                            ),
                            shape: BoxShape.circle),
                      ),
                    ),
                  );
                }
              } else if (snapshot.hasError) {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      width: widget.sz.width * 0.3,
                      height: widget.sz.height * 0.3,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: PrimaryColor,
                            width: 5,
                          ),
                          shape: BoxShape.circle),
                      child: const Text('No data'),
                    ),
                  ),
                );
              } else {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      padding: const EdgeInsets.all(0),
                      width: widget.sz.width * 0.3,
                      height: widget.sz.height * 0.3,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image:
                                  AssetImage('assets/images/user-profile.png')),
                          border: Border.all(
                            color: PrimaryColor,
                            width: 5,
                          ),
                          shape: BoxShape.circle),
                    ),
                  ),
                );
              }
            }),
        Positioned(
            bottom: widget.sz.height * 0.15,
            left: widget.sz.width * 0.4,
            child: Text(
              widget.name,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.sz.height * 0.03,
                  fontFamily: 'Raleway'),
            )),
      ],
    );
  }
}
