part of 'nav_bar_bloc.dart';

class NavBarState extends Equatable {
  final int currentIndex;

  const NavBarState({required this.currentIndex});

  @override
  List<Object?> get props => [currentIndex];

  factory NavBarState.initial() => const NavBarState(currentIndex: 0);

  NavBarState copyWith({final int? currentIndex}) {
    return NavBarState(currentIndex: currentIndex ?? this.currentIndex);
  }
}
