import 'package:flutter/cupertino.dart';
import 'business/notifications_service.dart';
import 'locator.dart';
import 'ui/app.dart';

void main() async {
  await buildDependencyGraph();
  final notificationsStream = locator<NotificationsService>().notificationStream;
  notificationsStream.listen((event) {
    print('Receive event from ui: $event');
  });
  runApp(const App());
}