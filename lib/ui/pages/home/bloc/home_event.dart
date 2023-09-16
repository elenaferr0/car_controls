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

@immutable
class SaveTrackHomeEvent extends HomeEvent {
  final String uri;

  SaveTrackHomeEvent(this.uri);
}

@immutable
class RemoveTrackHomeEvent extends HomeEvent {
  final String uri;

  RemoveTrackHomeEvent(this.uri);
}

@immutable
class ToggleShuffleHomeEvent extends HomeEvent {
  final bool currentStatus;

  ToggleShuffleHomeEvent(this.currentStatus);
}

enum Direction { up, down, left, right }

@immutable
class SwipeGestureDetectedHomeEvent extends HomeEvent {
  final Direction direction;

  SwipeGestureDetectedHomeEvent(this.direction);
}
