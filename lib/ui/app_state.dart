part of 'app_bloc.dart';

class AppState {
  final bool isNotificationModalOpen;

  const AppState({
    this.isNotificationModalOpen = false,
  });

  AppState copyWith({
    final bool? isNotificationModalOpen,
  }) =>
      AppState(
        isNotificationModalOpen:
            isNotificationModalOpen ?? this.isNotificationModalOpen,
      );
}
