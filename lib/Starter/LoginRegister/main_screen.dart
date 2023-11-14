import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:solace/Starter/LoginRegister/login_cover.dart';
import 'package:solace/Starter/LoginRegister/login_form.dart';
import 'package:solace/Starter/LoginRegister/register_form.dart';

import 'package:solace/backend/form_handler.dart';
import 'package:solace/backend/states.dart';

import 'package:solace/theme/color_scheme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    bool login = Provider.of<StateController>(context).seq == 1 ? true : false;
    return SafeArea(
      child: Scaffold(
        body: login
            ? SingleChildScrollView(
                child: Column(
                  children: [
                    LoginCover(
                      size: widget.size,
                      login: login,
                    ),
                    ShowForm(
                      widget: widget,
                      login: true,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: widget.size.height * 0.01),
                      child: Text('or',
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: widget.size.height * 0.015,
                              fontFamily: 'Raleway-Medium')),
                    ),
                    TextButton(
                      onPressed: (() {
                        Provider.of<StateController>(context, listen: false)
                            .incrementSeq(2);
                      }),
                      child: Text('create new account.',
                          style: TextStyle(
                              color: PrimaryColor,
                              fontSize: widget.size.height * 0.015,
                              fontFamily: 'Raleway-Medium')),
                    ),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    LoginCover(
                      size: widget.size,
                      login: login,
                    ),
                    ShowForm(
                      widget: widget,
                      login: false,
                    ),
                    TextButton(
                      onPressed: (() {
                        Provider.of<StateController>(context, listen: false)
                            .incrementSeq(1);
                      }),
                      child: Text('already have an account?',
                          style: TextStyle(
                              color: PrimaryColor,
                              fontSize: widget.size.height * 0.015,
                              fontFamily: 'Raleway-Medium')),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class ShowForm extends StatelessWidget {
  const ShowForm({
    Key? key,
    required this.widget,
    required this.login,
  }) : super(key: key);

  final MainScreen widget;
  final bool login;

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, widget.size.height * 0.05, 0, 0),
        child: ChangeNotifierProvider<FormHandler>(
          child: login
              ? LoginForm(size: widget.size)
              : RegisterForm(size: widget.size),
          create: (_) => FormHandler(),
        ));
  }
}
