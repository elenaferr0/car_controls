import 'package:injectable/injectable.dart';
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

    if (!connected)  throw SpotifyRemoteConnectionFailed();
  }
}
