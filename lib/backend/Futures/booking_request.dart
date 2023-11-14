import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/backend/form_handler.dart';
import 'package:solace/backend/states.dart';

Future sendData(BuildContext ctx, String submitType) async {
  await FirebaseFirestore.instance
      .collection('solace')
      .doc('bookings')
      .collection('bookings')
      .add(submitType == 'scheduleBookings'
          ? Provider.of<FormHandler>(ctx, listen: false).scheduleForm
          : Provider.of<FormHandler>(ctx, listen: false).emergencyForm)
      .then((value) {
    if (submitType == 'scheduleBookings') {
      Provider.of<StateController>(ctx, listen: false).changePage(2);
    } else {
      Provider.of<StateController>(ctx, listen: false).changeCurrentDoc(value.id);
      Provider.of<StateController>(ctx, listen: false).setArrivalTime();
      Provider.of<StateController>(ctx, listen: false).startArrivalTimer();
      Provider.of<StateController>(ctx, listen: false).incrementFormState();
    }
  }).catchError((error) {
    // ignore: invalid_return_type_for_catch_error
    return ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
      content: Text(error.toString()),
      duration: const Duration(seconds: 2),
      action: SnackBarAction(
        label: 'okay',
        onPressed: () {},
      ),
    ));
  });
}
