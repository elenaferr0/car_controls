part of 'nav_bar_bloc.dart';

class NavBarState extends Equatable {
  final NavBarIndex currentIndex;
  final bool hasUnreadNotifications;

  const NavBarState({
    required this.currentIndex,
    this.hasUnreadNotifications = false,
  });

  @override
  List<Object?> get props => [currentIndex, hasUnreadNotifications];

  factory NavBarState.initial() => const NavBarState(
        currentIndex: NavBarIndex.home,
      );

  NavBarState copyWith({
    final NavBarIndex? currentIndex,
    final bool? hasUnreadNotifications,
  }) {
    return NavBarState(
      currentIndex: currentIndex ?? this.currentIndex,
      hasUnreadNotifications:
          hasUnreadNotifications ?? this.hasUnreadNotifications,
    );
  }
}
