import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../business/models/minimal_notification.dart';
import '../../../../business/notifications_service.dart';
import '../../../router/app_router.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

@injectable
class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsService _notificationsService;
  final AppRouter _appRouter;
  late final StreamSubscription<MinimalNotification> _notificationsSubscription;
  final notificationDuration = const Duration(seconds: 3, milliseconds: 500);

  NotificationsBloc(
    this._notificationsService,
    this._appRouter,
  ) : super(const NotificationsState()) {
    _notificationsSubscription =
        _notificationsService.notificationStream.listen(
      (final event) => add(OpenNotificationModalAppEvent(event)),
    );

    on<NotificationsEvent>((final event, final emitter) async {
      switch (event) {
        case OpenNotificationModalAppEvent():
          await _openNotificationModal(event, emitter);
        case CloseNotificationModalAppEvent():
          await _closeNotificationModal(event, emitter);
      }
    });
  }

  Future<void> _openNotificationModal(
    final OpenNotificationModalAppEvent event,
    final Emitter<NotificationsState> emitter,
  ) async {
    if (state.isNotificationModalOpen) {
      return;
    }
    unawaited(_appRouter.showNotificationModal(event.notification));
    emitter(state.copyWith(isNotificationModalOpen: true));

    Future.delayed(
      notificationDuration,
      () => add(const CloseNotificationModalAppEvent()),
    );
  }

  Future<void> _closeNotificationModal(
    final CloseNotificationModalAppEvent event,
    final Emitter<NotificationsState> emitter,
  ) async {
    if (!state.isNotificationModalOpen) {
      return;
    }
    emitter(state.copyWith(isNotificationModalOpen: false));
    _appRouter.closeNotificationModal();
  }

  @override
  Future<void> close() {
    _notificationsSubscription.cancel();
    return super.close();
  }
}
