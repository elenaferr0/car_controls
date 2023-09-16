part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {}

class AvailableDataHomeState extends HomeState {
  final Track track;
  final Uint8List? image;
  final bool isPaused;
  final bool isTrackInLibrary;

  AvailableDataHomeState({
    required this.track,
    required this.isPaused,
    required this.image,
    required this.isTrackInLibrary,
  });

  AvailableDataHomeState copyWith({
    final Track? track,
    final Uint8List? image,
    final bool? isPaused,
    final bool? isTrackInLibrary,
  }) {
    return AvailableDataHomeState(
      track: track ?? this.track,
      image: image ?? this.image,
      isPaused: isPaused ?? this.isPaused,
      isTrackInLibrary: isTrackInLibrary ?? this.isTrackInLibrary,
    );
  }

  @override
  List<Object?> get props => [track.uri, isPaused, isTrackInLibrary];
}

class NoDataHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}
