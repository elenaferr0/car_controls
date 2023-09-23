import 'dart:typed_data';

import 'package:flutter_notification_listener/flutter_notification_listener.dart';

class MinimalNotification {
  String? app;
  Uint8List? icon;
  String? title;
  String? text;

  MinimalNotification({
    required this.app,
    this.icon,
    this.title,
    this.text,
  });

  MinimalNotification.fromNotificationEvent(
    final NotificationEvent event,
  ) : this(
          app: event.packageName,
          icon: event.largeIcon,
          title: event.title,
          text: event.text,
        );
}
