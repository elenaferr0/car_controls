import 'dart:async';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import 'models/minimal_notification.dart';

@singleton
class NotificationsService {
  final _port = ReceivePort();
  static final log = Logger('NotificationsService');
  final _controller = StreamController<MinimalNotification>.broadcast();
  final List<String> _allowedChannelIds = [
    'com.android.shell',
    // telegram
    'org.telegram.messenger',
    // whatsapp
    'com.whatsapp',
  ];

  Stream<MinimalNotification> get notificationStream => _controller.stream;

  @pragma('vm:entry-point')
  static void _callback(final NotificationEvent evt) {
    log.info('send evt to ui: $evt');
    final SendPort? send = IsolateNameServer.lookupPortByName('_listener_');
    if (send == null) log.info("can't find the sender");
    send?.send(evt);
  }

  @PostConstruct(preResolve: true)
  Future<void> initPlatformState() async {
    unawaited(NotificationsListener.initialize(callbackHandle: _callback));

    // this can fix restart<debug> can't handle error
    IsolateNameServer.removePortNameMapping('_listener_');
    IsolateNameServer.registerPortWithName(_port.sendPort, '_listener_');
    _port.listen((final event) {
      if (!_allowedChannelIds.contains(event.packageName)) {
        return;
      }
      log.fine('receive event from background: $event');
      _controller.add(MinimalNotification.fromNotificationEvent(event));
    });

    // don't use the default receivePort
    // NotificationsListener.receivePort.listen((evt) => onData(evt));

    final isRunning = (await NotificationsListener.isRunning) ?? false;
    log.info("""Service is ${!isRunning ? "not " : ""}already running""");

    await _startListening();
  }

  Future<void> _startListening() async {
    log.info('start listening');
    final hasPermission = (await NotificationsListener.hasPermission) ?? false;
    if (!hasPermission) {
      log.info('no permission, so open settings');
      await NotificationsListener.openPermissionSettings();
      return;
    }

    final isRunning = (await NotificationsListener.isRunning) ?? false;

    if (!isRunning) {
      await NotificationsListener.startService(
        foreground: false,
        title: 'Listener Running',
        description: 'Welcome to having me',
      );
    }
  }

  @disposeMethod
  Future<void> stopListening() async {
    log.info('stop listening');
    await NotificationsListener.stopService();
  }
}
