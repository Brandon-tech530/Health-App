import 'package:flutter/material.dart';

class DataBank1 extends ChangeNotifier {
  // booking_data.dart
  List<Map<String, dynamic>> bookedAppointments = [];
  // ignore: unused_element
  //List<Map<String, dynamic>> get _bookedAppointments => bookedAppointments;
  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }
}
