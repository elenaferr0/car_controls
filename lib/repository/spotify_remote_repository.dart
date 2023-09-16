import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import '../business/exceptions/spotify_remote_connection_failed_exception.dart';

@singleton
class SpotifyRemoteRepository {
  final String _clientId;
  final String _redirectUrl;

  SpotifyRemoteRepository(
    @Named('clientId') this._clientId,
    @Named('redirectUrl') this._redirectUrl,
  );

  @PostConstruct(preResolve: true)
  Future<void> connect() async {
    final connected = await SpotifySdk.connectToSpotifyRemote(
      clientId: _clientId,
      redirectUrl: _redirectUrl,
    );

    if (!connected) throw SpotifyRemoteConnectionFailed();
  }

  Stream<PlayerState> playerState() {
    return SpotifySdk.subscribePlayerState();
  }

  Future<void> skipPrevious() async {
    await SpotifySdk.skipPrevious();
  }

  Future<void> skipNext() async {
    await SpotifySdk.skipNext();
  }

  Future<void> pause() async {
    await SpotifySdk.pause();
  }

  Future<void> play() async {
    await SpotifySdk.resume();
  }

  Future<void> toggleShuffle() async {
    await SpotifySdk.toggleShuffle();
  }

  Future<bool> isPaused() async {
    final playerState = await SpotifySdk.getPlayerState();
    return playerState!.isPaused;
  }

  Future<PlayerState?> getPlayerState() async {
    return SpotifySdk.getPlayerState();
  }

  // image
  Future<Uint8List?> getImage(
    final ImageUri? imageUri, {
    final ImageDimension dimension = ImageDimension.large,
  }) async {
    if (imageUri == null) return null;
    return SpotifySdk.getImage(imageUri: imageUri, dimension: dimension);
  }
}
