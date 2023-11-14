import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Driver/driver_main.dart';
import 'package:solace/Pages/home_page.dart';

import 'package:solace/Starter/IntialScreen/initial_screen.dart';
import 'package:solace/Starter/LoginRegister/main_screen.dart';

import 'package:solace/backend/states.dart';

class BaseRouter extends StatefulWidget {
  const BaseRouter({super.key});

  @override
  State<BaseRouter> createState() => _BaseRouterState();
}

class _BaseRouterState extends State<BaseRouter> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.email!.contains('user')) {
              return HomePage();
            } else {
              return const DriverMain();
            }
          } else {
            return Provider.of<StateController>(context).seq == 0
                ? InitialScreen(size: size)
                : MainScreen(
                    size: size,
                  );
          }
        });
  }
}
