import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Widgets/drop_down.dart';
import 'package:solace/Widgets/field.dart';
import 'package:solace/Pages/Booking/Submit.dart';

import 'package:solace/backend/form_handler.dart';
import 'package:solace/backend/states.dart';
import 'package:solace/theme/color_scheme.dart';

class ScheduleForm extends StatefulWidget {
  const ScheduleForm({
    Key? key,
    required this.size,
    required GlobalKey<FormState> formKey,
  })  : _formKey = formKey,
        super(key: key);

  final Size size;

  final GlobalKey<FormState> _formKey;

  @override
  State<ScheduleForm> createState() => _ScheduleFormState();
}

class _ScheduleFormState extends State<ScheduleForm> {
  final List<String> labelList = [
    'Name',
    'Phone',
    'Pickup location',
    'Dropoff Hospital'
  ];

  final List<String> suggestionList = [
    'Kamran Ali.',
    '03433921422',
    '12th street, sunset boulevard',
    'Agha Khan Hospital'
  ];

  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(widget.size.height * 0.02),
          child: InkWell(
            onTap: () {
              _selectTime(context);
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: PrimaryColor, width: 1),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(0, 2),
                        color: SecondaryFont.withOpacity(0.4))
                  ],
                  borderRadius: BorderRadius.circular(5),
                ),
                height: widget.size.height * 0.04,
                width: widget.size.width * 0.3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.av_timer,
                        color: PrimaryColor,
                      ),
                    ),
                    SizedBox(
                      width: widget.size.width * 0.01,
                    ),
                    Text(
                        selectedTime.hour < 12
                            ? selectedTime.hour < 10
                                ? "0${selectedTime.hour}:${selectedTime.minute} am"
                                : "${selectedTime.hour - 12}:${selectedTime.minute} am"
                            : selectedTime.hour < 10
                                ? "0${selectedTime.hour}:${selectedTime.minute} pm"
                                : "${selectedTime.hour - 12}:${selectedTime.minute} pm",
                        style: const TextStyle(
                            color: PrimaryColor,
                            fontFamily: 'Raleway-Regular')),
                  ],
                ),
              ),
            ),
          ),
        ),
        for (int i = 0; i < 4; i++)
          Field(
            dark: false,
            size: widget.size,
            label: labelList[i],
            suggestion: suggestionList[i],
            userType: '',
            formType: 'schedule',
          ),
        DropDown(
          width: widget.size.width,
          label: 'Ambulance Type',
          cb: (type) {
            Provider.of<StateController>(context, listen: false)
                .changeAmbulance(type);
          },
          list: Provider.of<StateController>(context, listen: false).list2,
          val: Provider.of<StateController>(context, listen: false).data2,
        ),
        SubmitButton(
          size: widget.size,
          formKey: widget._formKey,
          dark: false,
          label: 'Schedule Ambulance',
          submitType: 'scheduleBookings',
        ),
      ],
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
        Provider.of<FormHandler>(context, listen: false)
            .scheduleRecord('Time', selectedTime.toString());
      });
    }
  }
}
