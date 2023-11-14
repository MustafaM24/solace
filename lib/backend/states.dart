import 'dart:async';

import 'package:flutter/cupertino.dart';

class StateController extends ChangeNotifier {
  int seq = 0;
  int bookingState = 0;
  bool emergency = true;

  String data2 = 'First Responder';
  String data1 = 'Minor Road Accident';
//  String data0 = 'Edhi';
  int arrivalTime = 10;
  int rideTime = 1;
  int pagenum = 0;
  String userType = 'user';

  String CurrentDoc = '';
  void changeCurrentDoc(String id) {
    CurrentDoc = id;
    notifyListeners();
  }

  String getCurrentDoc() {
    return CurrentDoc;
  }

  void changeUserType(String type) {
    userType = type;
    notifyListeners();
  }

  bool ride = false;
  late Timer timer;

  List<String> list2 = [
    'Basic Life Support',
    'Advanced Life Support',
    'Patient Transport',
    'First Responder',
  ];

  List<String> list1 = [
    'Minor Road Accident',
    'Fracture',
    'Heart Attack',
    'Open Wound',
    'Car Accident',
  ];

  List<String> ambulanceInformation = [];
  List<String> profileInformation = [];
  List<String> ambulanceInformationtitles = [
    'Delivery Code',
    'Driver Name',
    'Ambulance Number',
    'Destination',
    'Condition',
    'Cell',
  ];

  void loadProfileInformation(Map<String, String> data) {
    for (var value in data.values) {
      profileInformation.add(value);
    }
  }

  void incrementSeq(int n) {
    seq = n;
    notifyListeners();
  }

  void changePage(int n) {
    pagenum = n;

    notifyListeners();
  }

  void incrementFormState() {
    if (bookingState > 1) {
      arrivalTime = 0;
      bookingState = 0;
    } else {
      bookingState++;
    }

    notifyListeners();
  }

  void changeAccident(String type) {
    data1 = type;
    notifyListeners();
  }

  String getAccident() {
    return data1;
  }

  void changeAmbulance(String type) {
    data2 = type;
    notifyListeners();
  }

  String getAmbulance() {
    return data2;
  }

  void setArrivalTime() {
    arrivalTime = 50;
    notifyListeners();
  }

  void setRideTime() {
    rideTime = 20;
    notifyListeners();
  }

  void startRideTimer() {
    ride = !ride;
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (rideTime == 0) {
          timer.cancel();
          ride = !ride;
          incrementFormState();
        } else {
          rideTime--;
          notifyListeners();
        }
      },
    );
  }

  void startArrivalTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (arrivalTime == 0) {
          setRideTime();
          startRideTimer();
          timer.cancel();

          notifyListeners();
        } else {
          arrivalTime--;
          notifyListeners();
        }
      },
    );
  }
}
