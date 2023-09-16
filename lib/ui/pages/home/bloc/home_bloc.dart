import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/models/track.dart';
import '../../../../business/spotify_remote_service.dart';
import '../../../../business/volume_service.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SpotifyRemoteService _spotifyRemoteService;
  final VolumeService _volumeService;
  late final StreamSubscription _playerSubscription;
  final Map<ImageUri, Uint8List> _cachedImages = {};

  HomeBloc(
    this._spotifyRemoteService,
    this._volumeService,
  ) : super(NoDataHomeState()) {
    _playerSubscription =
        _spotifyRemoteService.playerState.listen(_onPlayerStateChanged);
    on<HomeEvent>((final event, final emitter) async {
      switch (event) {
        case PlayHomeEvent():
          await _resume();
        case PauseHomeEvent():
          await _pause();
        case SkipNextHomeEvent():
          await _skipNext();
        case SkipPreviousHomeEvent():
          await _skipPrevious();
        case SaveTrackHomeEvent():
          await _saveTrack(event.uri);
        case RemoveTrackHomeEvent():
          await _removeTrack(event.uri);
        case ToggleShuffleHomeEvent():
          await _toggleShuffle(event, emitter);
        case SwipeGestureDetectedHomeEvent():
          _swipeGestureDetected(event, emitter);
      }
    });
  }

  Future<void> _resume() async {
    await _spotifyRemoteService.performAction(PlayerAction.play);
  }

  Future<void> _pause() async {
    await _spotifyRemoteService.performAction(PlayerAction.pause);
  }

  Future<void> _skipNext() async {
    await _spotifyRemoteService.performAction(PlayerAction.skipNext);
  }

  Future<void> _skipPrevious() async {
    await _spotifyRemoteService.performAction(PlayerAction.skipPrevious);
  }

  Future<void> _onPlayerStateChanged(final PlayerState? playerState) async {
    if (playerState == null || playerState.track == null) {
      emit(NoDataHomeState());
      return;
    }

    late Uint8List? image;
    if (!_cachedImages.containsKey(playerState.track!.imageUri)) {
      image = await _spotifyRemoteService.getImage(
        playerState.track!.imageUri,
      );
      if (image != null) _cachedImages[playerState.track!.imageUri] = image;
    } else {
      image = _cachedImages[playerState.track!.imageUri];
    }

    final isTrackInLibrary = await _spotifyRemoteService.isTrackInLibrary(
      playerState.track!.uri,
    );

    emit(AvailableDataHomeState(
      track: playerState.track!,
      isPaused: playerState.isPaused,
      image: image,
      isTrackInLibrary: isTrackInLibrary,
      isShuffleEnabled: playerState.playbackOptions.isShuffling,
    ));
  }

  Future<void> _saveTrack(final String uri) async {
    await _spotifyRemoteService.saveTrack(uri);
  }

  Future<void> _removeTrack(final String uri) async {
    await _spotifyRemoteService.removeTrack(uri);
  }

  Future<void> _toggleShuffle(
    final HomeEvent event,
    final Emitter emitter,
  ) async {
    await _spotifyRemoteService
        .toggleShuffle((state as AvailableDataHomeState).isShuffleEnabled);
  }

  void _swipeGestureDetected(
    final SwipeGestureDetectedHomeEvent event,
    final Emitter emitter,
  ) {
    if (event.direction == Direction.up) {
      _volumeService.increaseVolume(VolumeService.defaultVolumeDelta);
    } else if (event.direction == Direction.down) {
      _volumeService.decreaseVolume(VolumeService.defaultVolumeDelta);
    } else if (event.direction == Direction.left) {
      add(SkipNextHomeEvent());
    } else if (event.direction == Direction.right) {
      add(SkipPreviousHomeEvent());
    }
  }

  @override
  Future<void> close() async {
    await _playerSubscription.cancel();
    await KeepScreenOn.turnOff();
    return super.close();
  }
}
