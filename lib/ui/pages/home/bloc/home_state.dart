part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class AvailableDataHomeState extends HomeState {
  final Track track;
  final Uint8List? image;
  final bool isPaused;
  final bool isTrackInLibrary;
  final bool isShuffleEnabled;

  AvailableDataHomeState({
    required this.track,
    required this.isPaused,
    required this.image,
    required this.isTrackInLibrary,
    required this.isShuffleEnabled,
  });

  AvailableDataHomeState copyWith({
    final Track? track,
    final Uint8List? image,
    final bool? isPaused,
    final bool? isTrackInLibrary,
    final bool? isShuffleEnabled,
  }) {
    return AvailableDataHomeState(
      track: track ?? this.track,
      image: image ?? this.image,
      isPaused: isPaused ?? this.isPaused,
      isTrackInLibrary: isTrackInLibrary ?? this.isTrackInLibrary,
      isShuffleEnabled: isShuffleEnabled ?? this.isShuffleEnabled,
    );
  }

  @override
  List<Object?> get props =>
      [track.uri, isPaused, isTrackInLibrary, isShuffleEnabled];
}

class NoDataHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}
