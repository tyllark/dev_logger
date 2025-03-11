import 'package:dev_logger/logs/logger_list.dart';
import 'package:flutter/material.dart';

class LoggerPage extends StatelessWidget {
  const LoggerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Logs'), centerTitle: true),
      body: SafeArea(child: LoggerList()),
    );
  }
}
