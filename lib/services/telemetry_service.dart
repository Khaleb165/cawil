import 'dart:convert';
import 'dart:io';
import 'package:logging/logging.dart';

class TelemetryService {
  static final TelemetryService _instance = TelemetryService._internal();
  late final Logger _logger;
  final _otelLogUrl = Uri.parse('http://api:4318/v1/logs');

  factory TelemetryService() => _instance;

  TelemetryService._internal();

  Future<void> initialize() async {
    // Configure root logger
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen(_handleLogRecord);

    _logger = Logger('cawil_app');
  }

  Logger get logger => _logger;

  void logInfo(String message) {
    _logger.info("[INFO] - $message");
  }

  void logWarning(String message) {
    _logger.warning("[WARNNG] - $message");
  }

  void logError(String message, [Object? error, StackTrace? stackTrace]) {
    _logger.severe("[SEVERE] - $message", error, stackTrace);
  }

  Future<void> _handleLogRecord(LogRecord record) async {
    // Always print to console
    print('${record.level.name}: ${record.time}: ${record.message}');

    try {
      final payload = _buildOtelLogPayload(record);
      final request = await HttpClient().postUrl(_otelLogUrl);
      request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
      request.add(utf8.encode(jsonEncode(payload)));

      final response = await request.close();
      if (response.statusCode >= 400) {
        print('Failed to send log: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending log to OTEL: $e');
    }
  }

  Map<String, dynamic> _buildOtelLogPayload(LogRecord record) {
    final now = DateTime.now().toUtc().microsecondsSinceEpoch * 1000; // nanos

    return {
      "resourceLogs": [
        {
          "resource": {
            "attributes": [
              {
                "key": "service.name",
                "value": {"stringValue": "cawil_app"}
              },
              {
                "key": "logger.name",
                "value": {"stringValue": record.loggerName}
              },
              {
                "key": "log.level",
                "value": {"stringValue": record.level.name}
              },
            ]
          },
          "scopeLogs": [
            {
              "scope": {"name": "cawil_logger", "version": "1.0.0"},
              "logRecords": [
                {
                  "timeUnixNano": now.toString(),
                  "severityNumber": _mapLevelToSeverity(record.level),
                  "severityText": record.level.name,
                  "body": {"stringValue": record.message},
                  "attributes": [
                    if (record.error != null)
                      {
                        "key": "exception",
                        "value": {"stringValue": record.error.toString()}
                      },
                    if (record.stackTrace != null)
                      {
                        "key": "stacktrace",
                        "value": {"stringValue": record.stackTrace.toString()}
                      }
                  ]
                }
              ]
            }
          ]
        }
      ]
    };
  }

  int _mapLevelToSeverity(Level level) {
    if (level == Level.SHOUT) {
      return 24;
    } else if (level == Level.SEVERE) {
      return 17;
    } else if (level == Level.WARNING) {
      return 13;
    } else if (level == Level.INFO) {
      return 9;
    } else if (level == Level.CONFIG ||
        level == Level.FINE ||
        level == Level.FINER ||
        level == Level.FINEST) {
      return 5;
    } else {
      return 1;
    }
  }
}
