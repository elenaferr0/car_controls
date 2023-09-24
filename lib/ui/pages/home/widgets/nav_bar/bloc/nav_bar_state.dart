part of 'nav_bar_bloc.dart';

class NavBarState extends Equatable {
  final NavBarIndex currentIndex;

  const NavBarState({
    required this.currentIndex,
  });

  @override
  List<Object?> get props => [currentIndex];

  factory NavBarState.initial() => const NavBarState(
        currentIndex: NavBarIndex.home,
      );

  NavBarState copyWith({
    final NavBarIndex? currentIndex,
  }) {
    return NavBarState(
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
