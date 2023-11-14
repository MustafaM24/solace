import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future signin(String email, String pass, BuildContext ctx) async {
  
  await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email, password: pass)
      .then((value) => {})
      .catchError((error) {
    // ignore: invalid_return_type_for_catch_error
    return ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: const Text('Something went wrong, try again'),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'okay',
        onPressed: () {},
      ),
    ));
  });
}
