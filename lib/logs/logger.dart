import 'dart:convert';
import 'package:dev_logger/logs/log_entry.dart';
import 'package:flutter/material.dart';

class Logger extends ChangeNotifier {
  static final Logger _instance = Logger._();
  static Logger get instance => _instance;

  final List<LogEntry> _logs = [];
  List<LogEntry> get logs => [..._logs];

  Logger._();

  static void log({required String action, Object? message}) {
    Logger.instance.logMessage(action: action, message: message);
  }

  void logMessage({required String action, Object? message}) {
    final formattedMessage = _formatMessage(message);

    // ignore: avoid_print
    print('Logger - $action');
    // ignore: avoid_print
    print('Logger - $formattedMessage');
    final logEntry = LogEntry(action: action, message: formattedMessage);

    _logs.add(logEntry);
    notifyListeners();
  }

  static final _jsonEncoder = JsonEncoder.withIndent('   ');
  String? _formatMessage(Object? message) {
    if (message == null) return null;
    final text = message.toString();

    try {
      return _jsonEncoder.convert(text);
    } catch (_) {
      return text;
    }
  }
}
