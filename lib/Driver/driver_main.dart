import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/Driver/current_bookings.dart';
import 'package:solace/Pages/UserProfile/user_profile.dart';
import 'package:solace/Pages/history/history.dart';
import 'package:solace/Widgets/app_bar.dart';
import 'package:solace/Widgets/bottom_navigationbar.dart';
import 'package:solace/backend/states.dart';

class DriverMain extends StatefulWidget {
  const DriverMain({super.key});

  @override
  State<DriverMain> createState() => _DriverMainState();
}

class _DriverMainState extends State<DriverMain> {
  final List<String> icons = [
    "assets/Icons/user",
    "assets/Icons/siren",
    "assets/Icons/time-past",
  ];
  List<String> labelList = ['Profile', 'Current', 'History'];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Provider.of<StateController>(context).pagenum == 0
              ? UserProfile(
                  sz: size,
                )
              : Provider.of<StateController>(context).pagenum == 1
                  ? UserInformation(
                      size: size,
                    )
                  : History(size: size)),
      appBar: myAppBar(),
      bottomNavigationBar: CustBottomNavigationBar(
        icons: icons,
        labelList: labelList,
      ),
    );
  }
}
