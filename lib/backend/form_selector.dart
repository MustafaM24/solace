import 'package:flutter/material.dart';

class NavigationState extends ChangeNotifier {
  int emergencySelect = 0;

  void changePage(int n) {
    emergencySelect = n;
    notifyListeners();
  }

  int recordSelect = 0;
    void changeRecord(int n) {
    emergencySelect = n;
    notifyListeners();
  }

}
