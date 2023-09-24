import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../business/models/minimal_notification.dart';
import '../../../../../../business/notifications_service.dart';
import '../../../../../router/app_router.dart';
import '../nav_bar_index.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';

@injectable
class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  final AppRouter _router;
  final NotificationsService _notificationsService;

  NavBarBloc(this._router, this._notificationsService)
      : super(NavBarState.initial()) {
    _notificationsService.notificationStream.listen(
      (final event) => add(ReceivedNotificationEvent(event)),
    );
    on<NavBarEvent>((final event, final emitter) {
      switch (event) {
        case NavBarEventTabChanged():
          _onTabChanged(event, emitter);
        case ReceivedNotificationEvent():
          _onNotificationReceived(event, emitter);
      }
    });
  }

  void _onTabChanged(
    final NavBarEventTabChanged event,
    final Emitter<NavBarState> emitter,
  ) {
    _router.goToNavBarItemWithIndex(event.selectedIndex);
    emitter(
      state.copyWith(
        currentIndex: event.selectedIndex,
        hasUnreadNotifications: event.selectedIndex == NavBarIndex.notifications
            ? false
            : state.hasUnreadNotifications,
      ),
    );
  }

  void _onNotificationReceived(
    final ReceivedNotificationEvent event,
    final Emitter<NavBarState> emitter,
  ) {
    if (state.currentIndex == NavBarIndex.notifications) {
      return;
    }
    emitter(state.copyWith(hasUnreadNotifications: true));
  }
}
