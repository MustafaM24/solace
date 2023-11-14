import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solace/Starter/LoginRegister/register_form.dart';

class FormHandler extends ChangeNotifier {
  Map<String, String> emergencyForm = {
    'Status': 'Requested',
    'form-type': 'Emergency'
  };

  Map<String, String> scheduleForm = {
    'Status': 'Requested',
    'Arrival Time': '',
    'form-type': 'Schedule'
  };
  String currentService = 'Edhi';

  List<String> serviceList = [
    'Edhi',
    'Chippa',
    'Aman',
    'Al-Khidmat',
  ];

  XFile? im;

  Future<void> pickImage(ImagePicker picker) async {
    im = await picker.pickImage(
      source: ImageSource.gallery,
    );
    notifyListeners();
  }

  XFile? getImage() {
    return im;
  }


  void changeService(String type) {
    currentService = type;
    notifyListeners();
  }

  Map<String, String> regData = {'Ride Count': '0'};
  void setRegData(String fieldName, String data) {
    regData[fieldName] = data;
    notifyListeners();
  }

  var user = UserType.user;

  void setUserType(UserType ut) {
    user = ut;
    notifyListeners();
  }

  Map<String, String> loginData = {'Email': '', 'Password': ''};

  void emergencyRecord(String fieldName, String data) {
    emergencyForm[fieldName] = data;
  }

  void scheduleRecord(String fieldName, String data) {
    scheduleForm[fieldName] = data;
  }

  void loginRecord(String fieldName, String data) {
    loginData[fieldName] = data;
  }

  String getLoginData(String fieldName) {
    return loginData[fieldName]!;
  }

  String? getData(String fieldName, String userType) {
    return regData[fieldName];
  }
}
