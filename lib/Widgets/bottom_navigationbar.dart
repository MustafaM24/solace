import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solace/theme/color_scheme.dart';

import '../backend/states.dart';

class CustBottomNavigationBar extends StatelessWidget {
  const CustBottomNavigationBar({
    Key? key, required this.icons, required this.labelList,
  }) : super(key: key);

  final List<String> icons;
 final  List<String> labelList;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle:
          const TextStyle(color: PrimaryFont, fontFamily: 'Raleway-Medium'),
      unselectedLabelStyle:
          const TextStyle(color: PrimaryFont, fontFamily: 'Raleway-Regular'),
      selectedItemColor: Colors.black,
      currentIndex: Provider.of<StateController>(context).pagenum,
      items: [
        for (int i = 0; i < icons.length; i++)
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('${icons[i]}.png'),
              ),
              label: labelList[i],
              tooltip: 'Profile'),
      ],
      onTap: (n) {
        if (n == 0) {
          Provider.of<StateController>(context, listen: false).changePage(0);
        } else if (n == 1) {
          Provider.of<StateController>(context, listen: false).changePage(1);
        } else {
          Provider.of<StateController>(context, listen: false).changePage(2);
        }
      },
    );
  }
}
