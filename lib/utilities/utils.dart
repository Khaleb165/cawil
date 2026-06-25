import 'package:cawil/models/available_bus.dart';

final List<AvailableBusModel> availableBuses = [
  AvailableBusModel(
    busNumber: 'Bus 1',
    reportTime: '07:30 AM',
    departureTime: '08:00 AM',
    arrivalTime: '10:00 AM',
    seatsLeft: 20,
    price: 80.0,
  ),
  AvailableBusModel(
    busNumber: 'Bus 2',
    reportTime: '09:00 AM',
    departureTime: '09:30 AM',
    arrivalTime: '11:30 AM',
    seatsLeft: 15,
    price: 100.0,
  ),
  AvailableBusModel(
    busNumber: 'Bus 3',
    reportTime: '10:30 AM',
    departureTime: '11:00 AM',
    arrivalTime: '01:00 PM',
    seatsLeft: 10,
    price: 120.0,
  ),
  AvailableBusModel(
    busNumber: 'Bus 4',
    reportTime: '01:00 PM',
    departureTime: '01:30 PM',
    arrivalTime: '03:30 PM',
    seatsLeft: 5,
    price: 140.0,
  ),
];
