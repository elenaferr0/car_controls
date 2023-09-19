import 'dart:typed_data';

import 'package:flutter_notification_listener/flutter_notification_listener.dart';

class MinimalNotification {
  String? sender;
  String? app;
  Uint8List? icon;
  String? title;
  String? body;

  MinimalNotification({
    required this.sender,
    required this.app,
    this.icon,
    this.title,
    this.body,
  });

  MinimalNotification.fromNotificationEvent(
    final NotificationEvent event,
  ) : this(
          sender: event.title,
          app: event.packageName,
          icon: event.largeIcon,
          title: event.title,
          body: event.message,
        );
}
