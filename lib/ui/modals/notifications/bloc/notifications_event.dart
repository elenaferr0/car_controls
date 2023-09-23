part of 'notifications_bloc.dart';

sealed class NotificationsEvent extends Equatable {
  const NotificationsEvent();
}

class OpenNotificationModalAppEvent extends NotificationsEvent {
  final MinimalNotification notification;

  const OpenNotificationModalAppEvent(this.notification);

  @override
  List<Object?> get props => [notification];
}

class CloseNotificationModalAppEvent extends NotificationsEvent {
  const CloseNotificationModalAppEvent();

  @override
  List<Object?> get props => [];
}