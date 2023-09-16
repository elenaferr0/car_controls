import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

@singleton
class LogService {
  late final StreamSubscription<LogRecord> _loggerSubscription;

  @postConstruct
  void init() {
    Logger.root.level = Level.ALL;
    _loggerSubscription = Logger.root.onRecord.listen(_onLogReceived);
  }

  @disposeMethod
  Future<void> dispose() async {
    await _loggerSubscription.cancel();
  }

  void _onLogReceived(final LogRecord log){
    if (kDebugMode) {
      print('${log.time} [${log.level}] ${log.loggerName} ${log.message}');
    }
  }
}
