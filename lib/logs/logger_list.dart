import 'package:dev_logger/logs/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class LoggerList extends StatefulWidget {
  final bool reverse;

  const LoggerList({super.key, this.reverse = false});

  @override
  State<LoggerList> createState() => _LoggerListState();
}

class _LoggerListState extends State<LoggerList> {
  final scrollController = ScrollController();
  static final _dateFormatter = DateFormat('hh:mm:ss.SSSS');

  @override
  void initState() {
    Logger.instance.addListener(_onLogAdded);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Logger.instance,
      builder: (context, child) {
        return ListView.separated(
          controller: scrollController,
          physics: ClampingScrollPhysics(),
          reverse: widget.reverse,
          itemCount: Logger.instance.logs.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final log = Logger.instance.logs[index];
            return GestureDetector(
              onTap: () => _copyToClipboard(log.message),
              child: ListTile(
                title: Text(
                  '${_dateFormatter.format(log.timestamp)} - ${log.action}',
                ),
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

  void _onLogAdded() {
    if (scrollController.position.pixels !=
        scrollController.position.maxScrollExtent) {
      return;
    }

    double screenHeight = MediaQuery.sizeOf(context).height;
    scrollController.animateTo(
      scrollController.position.maxScrollExtent + screenHeight,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
