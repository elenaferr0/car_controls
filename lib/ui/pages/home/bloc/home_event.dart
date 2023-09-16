part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

@immutable
class PlayHomeEvent extends HomeEvent {}

@immutable
class PauseHomeEvent extends HomeEvent {}

@immutable
class SkipNextHomeEvent extends HomeEvent {}

@immutable
class SkipPreviousHomeEvent extends HomeEvent {}
