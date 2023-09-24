part of 'nav_bar_bloc.dart';

abstract class NavBarEvent extends Equatable {
  const NavBarEvent();
}

class NavBarEventTabChanged extends NavBarEvent {
  final int index;

  const NavBarEventTabChanged({
    required this.index,
  });

  @override
  List<Object?> get props => [index];
}
