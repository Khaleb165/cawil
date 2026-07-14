import 'package:flutter/material.dart';
import 'package:cawil/model/available_bus.dart';

class BusData extends ChangeNotifier {
  String toTextField = '';
  String fromTextField = '';
  DateTime selectedDate = DateTime.now();
  List<String> selectedSeats = [];
  String joinedSeats = '';
  String nameOfTraveller = '';
  String phoneNumber = '';
  int? selectedScheduleId;
  String selectedBusNumber = '';
  int selectedBusTotalSeats = 32;
  int selectedScheduleSeatsLeft = 32;
  double selectedSchedulePrice = 80;
  Set<String> selectedBookedSeats = {};

  double get totalPrice {
    return selectedSeats.length * selectedSchedulePrice;
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

  void selectBus(AvailableBusModel bus) {
    selectedScheduleId = bus.scheduleId;
    selectedBusNumber = bus.busNumber ?? '';
    selectedBusTotalSeats = bus.totalSeats ?? bus.seatsLeft ?? 32;
    selectedScheduleSeatsLeft = bus.seatsLeft ?? selectedBusTotalSeats;
    selectedSchedulePrice = bus.price ?? 0;
    selectedBookedSeats = bus.bookedSeats.toSet();
    notifyListeners();
  }

  void addSeatSelection(String seatNumber) {
    if (isBookedSeat(seatNumber)) {
      return;
    }
    if (selectedSeats.length >= selectedScheduleSeatsLeft) {
      return;
    }
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

  bool isBookedSeat(String seatNumber) {
    return selectedBookedSeats.contains(seatNumber);
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
    selectedScheduleId = null;
    selectedBusNumber = '';
    selectedBusTotalSeats = 32;
    selectedScheduleSeatsLeft = 32;
    selectedSchedulePrice = 80;
    selectedBookedSeats = {};
    await clearData();
    notifyListeners();
  }
}
