
// ignore_for_file: avoid_print

import 'package:flutter_new_structure/app/global/app_config.dart';

class Logger {
  static void log(String message) {
    if (AppConfig.enableLogging) {
      final time = DateTime.now().toIso8601String();
      print('[$time] $message'); // Logs with a timestamp
    }
  }

  static void logError(String message, {dynamic error, StackTrace? stackTrace}) {
    if (AppConfig.enableLogging) {
      final time = DateTime.now().toIso8601String();
      print('[$time] ERROR: $message');
      if (error != null) print('[$time] ERROR Details: $error');
      if (stackTrace != null) print('[$time] StackTrace: $stackTrace');
    }
  }
}
