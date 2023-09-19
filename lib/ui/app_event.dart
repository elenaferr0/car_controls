part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();
}

class NotificationReceivedAppEvent extends AppEvent {
  final MinimalNotification notification;

  const NotificationReceivedAppEvent(this.notification);

  @override
  List<Object?> get props => [notification];
}
