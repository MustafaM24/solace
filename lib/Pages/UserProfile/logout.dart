import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solace/theme/color_scheme.dart';

class LogOut extends StatelessWidget {
  const LogOut({
    Key? key,
    required this.sz,
  }) : super(key: key);

  final Size sz;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        signout(context);
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: PrimaryColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                  color: SecondaryFont.withOpacity(0.4))
            ],
            borderRadius: BorderRadius.circular(5),
          ),
          height: sz.height * 0.06,
          width: sz.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Log out',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: sz.height * 0.02,
                      fontFamily: 'Raleway-Medium')),
            ],
          ),
        ),
      ),
    );
  }

  Future signout(BuildContext ctx) async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => () {})
        .catchError((error) {});
  }
}
