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

  NavBarBloc(this._router)
      : super(NavBarState.initial()) {
    on<NavBarEvent>((final event, final emitter) {
      switch (event) {
        case NavBarEventTabChanged():
          _onTabChanged(event, emitter);
      }
    });
  }

  void _onTabChanged(
    final NavBarEventTabChanged event,
    final Emitter<NavBarState> emitter,
  ) {
    _router.goToNavBarItemWithIndex(event.selectedIndex);
    emitter(
      state.copyWith(currentIndex: event.selectedIndex),
    );
  }
}
