part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class AvailableDataHomeState extends HomeState {
  final Track track;
  final Uint8List? image;
  final bool isPaused;

  AvailableDataHomeState({
    required this.track,
    required this.isPaused,
    required this.image,
  });
}

class NoDataHomeState extends HomeState {}
