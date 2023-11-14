// ignore_for_file: file_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Pages/Booking/BookingForm.dart';
import 'package:solace/Pages/Done/Done.dart';
import 'package:solace/Pages/Pending/pendingPage.dart';
import 'package:solace/backend/states.dart';

Container Pages(BuildContext context, double height, double width) {
  if (Provider.of<StateController>(context).bookingState == 0) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: BookingForm(
        height: height,
        width: width,
      ),
    );
  } else if (Provider.of<StateController>(context).bookingState == 1) {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: PendingPage(
          height: height,
          width: width,
        ));
  } else {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Done(
          height: height,
          width: width,
        ));
  }
}
