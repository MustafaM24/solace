import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/base_router.dart';
import 'package:solace/backend/states.dart';
import 'package:solace/theme/color_scheme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: SecondaryFont,
              ),
        ),
        home: ChangeNotifierProvider<StateController>(
          builder: (context, child) {
            // No longer throws
            return const BaseRouter();
          },
          create: (_) => StateController(),
        ));
  }
}
