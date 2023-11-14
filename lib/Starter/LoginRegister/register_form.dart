import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:solace/Widgets/drop_down.dart';
import 'package:solace/Widgets/field.dart';
import 'package:solace/backend/form_handler.dart';
import 'package:solace/theme/color_scheme.dart';
import '../../backend/Futures/signup.dart';

enum UserType { user, driver }

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.size});
  final Size size;
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  List<String> labelList = ['Name', 'User Name', 'Password', 'Phone'];
  List<String> suggestionList = [
    'Sameer Saleem',
    'sameer123',
    'xxxxxxx',
    '03xx123455'
  ];

  @override
  Widget build(BuildContext context) {
    var userType = Provider.of<FormHandler>(context).user;
    final ImagePicker picker = ImagePicker();
    XFile? im;
    // Pick an image

    return SizedBox(
      height: widget.size.height * 0.5,
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: widget.size.width * 0.12,
                          vertical: widget.size.height * 0.02),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                    spreadRadius: 2)
                              ],
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: PrimaryColor,
                                width: 2,
                              )),
                          child: IconButton(
                            color: PrimaryColor,
                            icon: const Icon(Icons.add_a_photo_outlined),
                            onPressed: () async {
                              //     _getFromCamera();
                              Provider.of<FormHandler>(context, listen: false)
                                  .pickImage(picker);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                for (int i = 0; i < 4; i++)
                  Field(
                    dark: false,
                    size: widget.size,
                    label: labelList[i],
                    suggestion: suggestionList[i],
                    userType: userType.toString(),
                    formType: 'register',
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                        activeColor: PrimaryColor,
                        value: UserType.user,
                        groupValue: userType,
                        onChanged: (val) {
                          setState(() {
                            Provider.of<FormHandler>(context, listen: false)
                                .setUserType(val as UserType);
                            //  _user = val as UserType;
                          });
                        }),
                    Text('User',
                        style: TextStyle(
                            fontSize: widget.size.height * 0.015,
                            fontFamily: 'Raleway-Medium')),
                    SizedBox(width: widget.size.width * 0.2),
                    Radio(
                        activeColor: PrimaryColor,
                        value: UserType.driver,
                        groupValue: userType,
                        onChanged: (val) {
                          setState(() {
                            Provider.of<FormHandler>(context, listen: false)
                                .setUserType(val as UserType);
                          });
                        }),
                    Text('Driver',
                        style: TextStyle(
                            fontSize: widget.size.height * 0.015,
                            fontFamily: 'Raleway-Medium')),
                  ],
                ),
                userType == UserType.driver
                    ? Column(
                        children: [
                          Field(
                            dark: false,
                            size: widget.size,
                            label: 'Ambulance Number',
                            suggestion: 'KMA-1099',
                            userType: userType.toString(),
                            formType: 'register',
                          ),
                          DropDown(
                            width: widget.size.width,
                            label: 'Service',
                            cb: (type) {
                              Provider.of<FormHandler>(context, listen: false)
                                  .changeService(type);
                            },
                            list:
                                Provider.of<FormHandler>(context, listen: false)
                                    .serviceList,
                            val:
                                Provider.of<FormHandler>(context, listen: false)
                                    .currentService,
                          )
                        ],
                      )
                    : Container(),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: widget.size.height * 0.02),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: (() {
                          registerMethod(context, im);
                        }),
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 1,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 2),
                                    color: SecondaryFont.withOpacity(0.4))
                              ],
                              color: PrimaryColor,
                              borderRadius: BorderRadius.circular(5)),
                          height: widget.size.height * 0.06,
                          width: widget.size.width * 0.75,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Sign up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: widget.size.height * 0.02,
                                      fontFamily: 'Raleway-Medium')),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  void registerMethod(BuildContext context, XFile? im) {
    if (_formKey.currentState!.validate()) {
      signup(
          Provider.of<FormHandler>(context, listen: false)
              .getData('User Name', 'user'),
          Provider.of<FormHandler>(context, listen: false)
              .getData('Password', 'user'),
          context);
    }
  }
}
