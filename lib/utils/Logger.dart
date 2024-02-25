import 'dart:developer' as developer;

class Logger {
  static final Logger instance = Logger._internal();
  Logger._internal();
  factory Logger() => instance;
  // main.dart
// Blue text
  void logInfo(String msg) {
    developer.log('\x1B[34m$msg\x1B[0m');
  }

// Green text
  void logSuccess(String msg) {
    developer.log('\x1B[32m$msg\x1B[0m');
  }

// Yellow text
  void logWarning(String msg) {
    developer.log('\x1B[33m$msg\x1B[0m');
  }

// Red text
  void logError(String msg) {
    developer.log('\x1B[31m$msg\x1B[0m');
  }
}
