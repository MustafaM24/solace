// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:solace/Pages/BookingPageSelector.dart';
import 'package:solace/Pages/UserProfile/user_profile.dart';
import 'package:solace/Pages/history/history.dart';

import 'package:solace/Widgets/app_bar.dart';
import 'package:solace/Widgets/bottom_navigationbar.dart';
import 'package:solace/backend/states.dart';

import 'Booking/status_indicator.dart';

class HomePage extends StatefulWidget {


  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> icons = [
    "assets/Icons/user",
    "assets/Icons/add",
    "assets/Icons/time-past",
  ];
  List<String> labelList = ['Profile', 'Book', 'History'];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    var sz = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: CustBottomNavigationBar(icons: icons, labelList: labelList,
 
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffFAF9F6),
      appBar: myAppBar(),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Provider.of<StateController>(context).pagenum == 1
              ? SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        child: StatusIndictor(),
                      ),
                      Column(
                        children: [
                          Card(
                            elevation: 6,
                            child: SizedBox(
                                height: size.height * 0.70,
                                width: size.width * 0.90,
                                child: Pages(context, size.height, size.width)),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Provider.of<StateController>(context).pagenum == 0
                  ? UserProfile(
                      sz: sz,
                    )
                  : History(size: size)),
    );
  }
}
