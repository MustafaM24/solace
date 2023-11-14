import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Pages/Booking/Submit.dart';
import 'package:solace/Widgets/drop_down.dart';
import 'package:solace/Widgets/field.dart';
import 'package:solace/backend/states.dart';

class EmergencyForm extends StatelessWidget {
  EmergencyForm({
    Key? key,
    required this.size,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final Size size;

  final GlobalKey<FormState> _formKey;
  final List<String> labelList = [
    'Name',
    'Phone',
    'Pickup location',
  ];
  final List<String> suggestionList = [
    'Kamran Ali.',
    '03433921322',
    '12th street, sunset boulevard',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < 3; i++)
          Field(
            dark: false,
            size: size,
            label: labelList[i],
            suggestion: suggestionList[i],
            userType: '',
            formType: 'emergency',
          ),
        DropDown(
          width: size.width,
          label: 'Accident Type',
          cb: (type) {
            Provider.of<StateController>(context, listen: false)
                .changeAccident(type);
          },
          list: Provider.of<StateController>(context, listen: false).list1,
          val: Provider.of<StateController>(context, listen: false).data1,
        ),
        SubmitButton(
          size: size,
          formKey: _formKey,
          dark: false,
          label: 'Request Ambulance',
          submitType: 'emergencyBookings',
        ),
      ],
    );
  }
}
