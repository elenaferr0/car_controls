import 'dart:async';

import 'package:bloc/bloc.dart';
import 'router/app_router.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../business/models/minimal_notification.dart';
import '../../../../business/notifications_service.dart';

part 'app_event.dart';

part 'app_state.dart';

@injectable
class AppBloc extends Bloc<AppEvent, AppState> {
  final NotificationsService _notificationsService;
  final AppRouter _appRouter;
  late final StreamSubscription<MinimalNotification> _notificationsSubscription;
  final notificationDuration = const Duration(seconds: 3, milliseconds: 500);

  AppBloc(
    this._notificationsService,
    this._appRouter,
  ) : super(const AppState()) {
    _notificationsSubscription =
        _notificationsService.notificationStream.listen(
      (final event) => add(
        OpenNotificationModalAppEvent(event),
      ),
    );

    on<AppEvent>((final event, final emitter) async {
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
    final Emitter<AppState> emitter,
  ) async {
    // TODO: if location is not the home page, do not open the modal
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
    final Emitter<AppState> emitter,
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
