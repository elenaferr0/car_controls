part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();
}

class OpenNotificationModalAppEvent extends AppEvent {
  final MinimalNotification notification;

  const OpenNotificationModalAppEvent(this.notification);

  @override
  List<Object?> get props => [notification];
}

class CloseNotificationModalAppEvent extends AppEvent {
  const CloseNotificationModalAppEvent();

  @override
  List<Object?> get props => [];
}