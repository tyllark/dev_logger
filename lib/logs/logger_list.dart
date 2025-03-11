
import 'package:dev_logger/logs/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoggerList extends StatelessWidget {
  const LoggerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: DevLogger.instance,
      builder: (context, child) {
        return ListView.separated(
          itemCount: DevLogger.instance.logs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final log = DevLogger.instance.logs[index];
            return GestureDetector(
              onTap: () => _copyToClipboard(log.message),
              child: ListTile(
                title: Text('${log.timestamp} - ${log.action}'),
                subtitle: Text(log.message),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
