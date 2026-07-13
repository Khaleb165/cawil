import 'package:intl/intl.dart';

class AvailableBusModel {
  int? scheduleId;
  String? busNumber;
  String? reportTime;
  String? departureTime;
  String? arrivalTime;
  int? seatsLeft;
  double? price;

  AvailableBusModel({
    this.scheduleId,
    this.busNumber,
    this.reportTime,
    this.departureTime,
    this.arrivalTime,
    this.seatsLeft,
    this.price,
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
      reportTime: _formatTime(report),
      departureTime: _formatTime(departure),
      arrivalTime: _formatTime(arrival),
      seatsLeft: (schedule['seats_remaining'] as num?)?.toInt(),
      price: (schedule['price'] as num?)?.toDouble(),
    );
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
