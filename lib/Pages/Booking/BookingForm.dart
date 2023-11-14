// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Pages/Booking/emergency_form.dart';
import 'package:solace/Pages/Booking/schedule_form.dart';
import 'package:solace/backend/form_handler.dart';

import 'package:solace/backend/form_selector.dart';

import 'package:solace/theme/color_scheme.dart';

class BookingForm extends StatefulWidget {
  final double width;
  final double height;
  const BookingForm({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ChangeNotifierProvider<NavigationState>(
              child: FormSelectorButton(
                size: size,
                formKey: _formKey,
              ),
              create: (_) => NavigationState(),
            ),
          ],
        ),
      ),
    );
  }
}

class FormSelectorButton extends StatelessWidget {
  const FormSelectorButton({
    Key? key,
    required this.size,
    required this.formKey,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Provider.of<NavigationState>(context).emergencySelect == 0
        ? Column(
            children: [
              Container(
                margin: EdgeInsets.all(size.height * 0.02),
                width: size.width * 0.51,
                height: size.height * 0.043,
                decoration: BoxDecoration(
                    color: SecondaryFont.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(size.width * 0.01),
                    border: Border.all(
                        width: 1, color: SecondaryFont.withOpacity(0.2))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        selectorButton(context, 0, 'Emergency'),
                        selectorButton(context, 1, 'Schedule')
                      ],
                    ),
                  ],
                ),
              ),
              ChangeNotifierProvider<FormHandler>(
                child: EmergencyForm(size: size, formKey: formKey),
                create: (_) => FormHandler(),
              ),
            ],
          )
        : Column(
            children: [
              Container(
                width: size.width * 0.51,
                height: size.height * 0.043,
                decoration: BoxDecoration(
                    color: SecondaryFont.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(size.width * 0.01),
                    border: Border.all(
                        width: 1, color: SecondaryFont.withOpacity(0.2))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        selectorButton(context, 0, 'Emergency'),
                        selectorButton(context, 1, 'Schedule')
                      ],
                    ),
                  ],
                ),
              ),
              ChangeNotifierProvider<FormHandler>(
                child: ScheduleForm(size: size, formKey: formKey),
                create: (_) => FormHandler(),
              ),
            ],
          );
  }

  InkWell selectorButton(BuildContext ctx, int n, String label) {
    return InkWell(
      onTap: (() {
        Provider.of<NavigationState>(ctx, listen: false).changePage(n);
      }),
      child: Container(
        width: size.width * 0.25,
        height: size.height * 0.040,
        decoration: BoxDecoration(
          color: Provider.of<NavigationState>(ctx).emergencySelect == n
              ? PrimaryColor
              : SecondaryFont.withOpacity(0.0),
          borderRadius: BorderRadius.circular(size.width * 0.01),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Provider.of<NavigationState>(ctx).emergencySelect == n
                ? const TextStyle(
                    fontFamily: 'Raleway',
                    color: Colors.white,
                    fontWeight: FontWeight.bold)
                : const TextStyle(
                    fontFamily: 'Raleway-Medium',
                    color: SecondaryFont,
                  ),
          ),
        ),
      ),
    );
  }
}
