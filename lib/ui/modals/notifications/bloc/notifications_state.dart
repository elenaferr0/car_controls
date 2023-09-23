part of 'notifications_bloc.dart';

class NotificationsState {
  final bool isNotificationModalOpen;

  const NotificationsState({
    this.isNotificationModalOpen = false,
  });

  NotificationsState copyWith({
    final bool? isNotificationModalOpen,
  }) =>
      NotificationsState(
        isNotificationModalOpen:
            isNotificationModalOpen ?? this.isNotificationModalOpen,
      );
}
