import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';
import 'package:spotify_sdk/enums/image_dimension_enum.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/models/player_state.dart';
import '../repository/spotify_remote_repository.dart';

enum PlayerAction { skipPrevious, skipNext, pause, play }

@singleton
class SpotifyRemoteService {
  final SpotifyRemoteRepository _repository;
  static final log = Logger('SpotifyRemoteService');

  const SpotifyRemoteService(this._repository);

  @PostConstruct(preResolve: true)
  Future<void> connect() async {
    // TODO: save in shared preferences
    // await _repository.askForAuthorization();
    await _repository.connect();
  }

  Future<void> performAction(final PlayerAction action) async {
    try {
      log.info('Performing ${action.name}');
      final matchingFunction = switch (action) {
        PlayerAction.skipPrevious => _repository.skipPrevious,
        PlayerAction.skipNext => _repository.skipNext,
        PlayerAction.pause => _repository.pause,
        PlayerAction.play => _repository.play,
      };

      await matchingFunction();
      log.fine('${action.name} performed successfully');
    } on PlatformException catch (platformException) {
      log.shout('Failed to perform action ${action.name}', platformException);
    } on MissingPluginException catch (missingPluginException) {
      log.shout(
          'Native platform implementation is missing', missingPluginException);
    }
  }

  Future<bool> isPaused() async {
    return _repository.isPaused();
  }

  Stream<PlayerState?> get playerState async* {
    // Allow the stream to emit the current player state when
    // subscribing to the stream
    yield await _repository.getPlayerState();
    yield* _repository.playerState();
  }

  Future<Uint8List?> getImage(
    final ImageUri? imageUri, {
    final ImageDimension dimension = ImageDimension.large,
  }) =>
      _repository.getImage(imageUri);

  Future<bool> isTrackInLibrary(final String uri) async =>
      _repository.isTrackInLibrary(uri);

  Future<void> saveTrack(final String uri) async => _repository.saveTrack(uri);

  Future<void> removeTrack(final String uri) async =>
      _repository.removeTrack(uri);

  Future<void> toggleShuffle(final bool currentStatus) async =>
      _repository.toggleShuffle(currentStatus);
}
