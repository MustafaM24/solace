import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solace/Starter/LoginRegister/register_form.dart';
import 'package:solace/backend/form_handler.dart';

Future signup(String? email, String? pass, BuildContext ctx) async {
  bool type =
      Provider.of<FormHandler>(ctx, listen: false).user == UserType.driver;
  var em = '';
  if (!type) {
    em = '$email.user@solace.com';
  } else {
    em = '$email.driver@solace.com';
  }
  Provider.of<FormHandler>(ctx, listen: false).setRegData('Email', em);
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: em, password: pass!)
        .then((value) {
      addUser(ctx, type, em);
    }).catchError((signUpError) {});
  } catch (signUpError) {
    if (signUpError is PlatformException) {
      if (signUpError.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        return 
        
        
        showAlertDialog(ctx, 'This email is already in use.',
            'Try another username or try logging in. ');
      }
    }
  }
}

Future addUser(BuildContext ctx, bool type, String email) async {
  User? user = FirebaseAuth.instance.currentUser;
  var im = Provider.of<FormHandler>(ctx, listen: false).getImage()!;
  FirebaseStorage.instance
      .ref()
      .child("/profile_pictures/${user!.uid}")
      .putFile(File(im.path));
  var data = Provider.of<FormHandler>(ctx, listen: false).regData;
  if (!type) {
    data.remove('Ambulance Number');
    data.remove('Service');
  } else {
    Provider.of<FormHandler>(ctx, listen: false).setRegData(
        'Service', Provider.of<FormHandler>(ctx, listen: false).currentService);
  }

    await FirebaseFirestore.instance
        .collection('solace')
        .doc('users')
        .collection(type ? 'driver' : 'regularUser')
        .doc(user.uid.toString())
        .set(data)
        .then((value) {
      return ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text('Your email is $email'),
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'okay',
          onPressed: () {},
        ),
      ));
    });

}

showAlertDialog(BuildContext context, String message, String title) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
