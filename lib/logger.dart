import 'dart:developer' as developer;

class Logger {
  static void log(String message) {
    developer.log(message);
  }

  static void error(String message, {dynamic error, StackTrace? stackTrace}) {
    developer.log(message, error: error, stackTrace: stackTrace, level: 500);
  }
}