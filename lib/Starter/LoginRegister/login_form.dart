import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Starter/LoginRegister/register_form.dart';
import 'package:solace/Widgets/field.dart';
import 'package:solace/backend/form_handler.dart';
import 'package:solace/theme/color_scheme.dart';

import '../../backend/Futures/signin.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  List<String> labelList = ['User Name', 'Password'];
  List<String> suggestionList = [
    'sameer123',
    'xxxxxxx',
  ];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var userType = Provider.of<FormHandler>(context).user;
    return Column(
      children: [
        Form(
            key: _formKey,
            child: Column(
              children: [
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
                for (int i = 0; i < 2; i++)
                  Field(
                    dark: false,
                    size: widget.size,
                    label: labelList[i],
                    suggestion: suggestionList[i],
                    userType: '',
                    formType: 'login',
                  ),
                loginButton(context, userType)
              ],
            )),
      ],
    );
  }

  Padding loginButton(BuildContext context, UserType ut) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.size.height * 0.02),
      child: Column(
        children: [
          InkWell(
            onTap: (() {
              if (_formKey.currentState!.validate()) {
                String userType = ut.toString().replaceAll('UserType.', '');
                String userName =
                    Provider.of<FormHandler>(context, listen: false)
                        .getLoginData('User Name');
                signin(
                    '$userName.$userType@solace.com',
                    Provider.of<FormHandler>(context, listen: false)
                        .getLoginData('Password'),
                    context);
              }
            }),
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                    color: SecondaryFont.withOpacity(0.4))
              ], color: PrimaryColor, borderRadius: BorderRadius.circular(5)),
              height: widget.size.height * 0.06,
              width: widget.size.width * 0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Login',
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
    );
  }
}
