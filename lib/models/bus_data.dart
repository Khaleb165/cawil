import 'package:flutter/material.dart';

class BusData extends ChangeNotifier {
  String toTextField = '';
  String fromTextField = '';
  DateTime selectedDate = DateTime.now();
  List<String> selectedSeats = [];
  String joinedSeats = '';
  String nameOfTraveller = '';
  String phoneNumber = '';

  double get totalPrice {
    return selectedSeats.length * 80;
  }

  void updateToTextField(String newText) {
    toTextField = newText;
    notifyListeners();
  }

  void updateFromTextField(String newText) {
    fromTextField = newText;
    notifyListeners();
  }

  void updateSelectedDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void addSeatSelection(String seatNumber) {
    selectedSeats.add(seatNumber);

    // concat selected seats into coma separated strings
    joinedSeats = selectedSeats.join(', ');
    notifyListeners();
  }

  void removeSeatSelection(String seatNumber) {
    selectedSeats.remove(seatNumber);

    // concat selected seats into coma separated strings
    joinedSeats = selectedSeats.join(', ');
    notifyListeners();
  }

  bool containSeat(String seatNumber) {
    return selectedSeats.contains(seatNumber);
  }

  void updateNameTextField(String newText) {
    nameOfTraveller = newText;
    notifyListeners();
  }

  void updatePhoneTextField(String newNumber) {
    phoneNumber = newNumber;
    notifyListeners();
  }

  Future<void> clearData() async {
    selectedSeats.clear();
    joinedSeats = '';
    notifyListeners();
  }

  Future<void> clearFieldsData() async {
    fromTextField = '';
    toTextField = '';
    nameOfTraveller = '';
    phoneNumber = '';
    notifyListeners();
  }
}
