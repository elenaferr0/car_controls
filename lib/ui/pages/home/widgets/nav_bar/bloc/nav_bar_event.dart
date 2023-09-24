part of 'nav_bar_bloc.dart';

sealed class NavBarEvent extends Equatable {
  const NavBarEvent();
}

class NavBarEventTabChanged extends NavBarEvent {
  final NavBarIndex selectedIndex;

  const NavBarEventTabChanged({
    required this.selectedIndex,
  });

  @override
  List<Object?> get props => [selectedIndex];
}

class ReceivedNotificationEvent extends NavBarEvent {
  final MinimalNotification notification;

  const ReceivedNotificationEvent(this.notification);

  @override
  List<Object?> get props => [notification];
}
