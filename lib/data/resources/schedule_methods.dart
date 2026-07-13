import 'package:cawil/data/remote/dio_client.dart';
import 'package:cawil/model/available_bus.dart';
import 'package:intl/intl.dart';

class ScheduleMethods {
  Future<List<AvailableBusModel>> searchSchedules({
    required String origin,
    required String destination,
    required DateTime date,
  }) async {
    final response = await DioClient().get(
      '/schedules',
      queryParameters: {
        'origin': origin.trim(),
        'destination': destination.trim(),
        'date': DateFormat('yyyy-MM-dd').format(date),
      },
      requiresAuth: false,
    );

    final schedules = response as List<dynamic>;
    return schedules
        .map((item) => AvailableBusModel.fromScheduleJson(
              Map<String, dynamic>.from(item as Map),
            ))
        .toList();
  }
}
