import 'package:intl/intl.dart';

class AvailableBusModel {
  int? scheduleId;
  String? busNumber;
  int? totalSeats;
  String? reportTime;
  String? departureTime;
  String? arrivalTime;
  int? seatsLeft;
  double? price;
  List<String> bookedSeats;

  AvailableBusModel({
    this.scheduleId,
    this.busNumber,
    this.totalSeats,
    this.reportTime,
    this.departureTime,
    this.arrivalTime,
    this.seatsLeft,
    this.price,
    this.bookedSeats = const [],
  });

  factory AvailableBusModel.fromScheduleJson(Map<String, dynamic> json) {
    final schedule = Map<String, dynamic>.from(json['schedule'] as Map);
    final busInfo = Map<String, dynamic>.from(json['bus_info'] as Map);
    final departure = _parseDateTime(schedule['departure_time']);
    final arrival = _parseDateTime(schedule['arrival_time']);
    final report = _parseDateTime(schedule['report_time']);

    return AvailableBusModel(
      scheduleId: schedule['id'] as int?,
      busNumber: busInfo['bus_number']?.toString(),
      totalSeats: _parseInt(busInfo['total_seats']),
      reportTime: _formatTime(report),
      departureTime: _formatTime(departure),
      arrivalTime: _formatTime(arrival),
      seatsLeft: _parseInt(schedule['seats_remaining']),
      price: _parseDouble(schedule['price']),
      bookedSeats: _parseStringList(schedule['booked_seats']),
    );
  }

  static List<String> _parseStringList(Object? value) {
    if (value is List) {
      return value
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .toList(growable: false);
    }
    return const [];
  }

  static int? _parseInt(Object? value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? _parseDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static DateTime? _parseDateTime(Object? value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString())?.toLocal();
  }

  static String _formatTime(DateTime? value) {
    if (value == null) return 'N/A';
    return DateFormat('hh:mm a').format(value);
  }
}
