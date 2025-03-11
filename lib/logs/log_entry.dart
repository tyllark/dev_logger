class LogEntry {
  final DateTime timestamp = DateTime.now();
  final String action;
  final String message;

  LogEntry(this.action, this.message);
}
