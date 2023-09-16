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
