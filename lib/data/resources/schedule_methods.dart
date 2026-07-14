import 'package:cawil/data/remote/dio_client.dart';
import 'package:cawil/model/available_bus.dart';
import 'package:intl/intl.dart';

class ScheduleLocations {
  final List<String> origins;
  final List<String> destinations;

  const ScheduleLocations({
    required this.origins,
    required this.destinations,
  });
}

class ScheduleMethods {
  Future<ScheduleLocations> getScheduleLocations() async {
    final response = await DioClient().get(
      '/schedules',
      requiresAuth: false,
    );

    final schedules = response as List<dynamic>;
    final origins = <String>{};
    final destinations = <String>{};

    for (final item in schedules) {
      final data = Map<String, dynamic>.from(item as Map);
      final schedule = Map<String, dynamic>.from(data['schedule'] as Map);
      final origin = schedule['origin']?.toString().trim();
      final destination = schedule['destination']?.toString().trim();

      if (origin != null && origin.isNotEmpty) {
        origins.add(origin);
      }
      if (destination != null && destination.isNotEmpty) {
        destinations.add(destination);
      }
    }

    return ScheduleLocations(
      origins: origins.toList()..sort(),
      destinations: destinations.toList()..sort(),
    );
  }

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
