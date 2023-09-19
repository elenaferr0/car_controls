import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../business/models/minimal_notification.dart';
import '../business/notifications_service.dart';
import 'router/app_router.dart';

part 'app_event.dart';

part 'app_state.dart';

@injectable
class AppBloc extends Bloc<AppEvent, AppState> {
  final NotificationsService _notificationsService;
  final AppRouter _appRouter;
  late final StreamSubscription<MinimalNotification> _notificationsSubscription;

  AppBloc(
    this._notificationsService,
    this._appRouter,
  ) : super(AppInitial()) {
    _notificationsSubscription = _notificationsService.notificationStream
        .listen((final event) => add(NotificationReceivedAppEvent(event)));

    on<AppEvent>((final event, final emit) async {
      switch (event) {
        case NotificationReceivedAppEvent():
          await _notificationReceivedEvent(event);
      }
    });
  }

  Future<void> _notificationReceivedEvent(
    final NotificationReceivedAppEvent event,
  ) async =>
      _appRouter.showNotificationModal(event.notification);

  @override
  Future<void> close() {
    _notificationsSubscription.cancel();
    return super.close();
  }
}
