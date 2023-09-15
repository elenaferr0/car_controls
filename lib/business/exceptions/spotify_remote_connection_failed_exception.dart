class SpotifyRemoteConnectionFailed implements Exception {
  final String message;

  SpotifyRemoteConnectionFailed([this.message = '']);
}