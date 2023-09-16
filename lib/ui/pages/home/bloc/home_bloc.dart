import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/models/track.dart';

import '../../../../business/spotify_remote_service.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SpotifyRemoteService _spotifyRemoteService;
  late final StreamSubscription _playerSubscription;

  HomeBloc(this._spotifyRemoteService) : super(NoDataHomeState()) {
    _playerSubscription =
        _spotifyRemoteService.playerState.listen(_onPlayerStateChanged);
    on<HomeEvent>((final event, final emit) async {
      switch (event) {
        case PlayHomeEvent():
          await _resume();
        case PauseHomeEvent():
          await _pause();
        case SkipNextHomeEvent():
          await _skipNext();
        case SkipPreviousHomeEvent():
          await _skipPrevious();
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
    } else {
      final image = await _spotifyRemoteService.getImage(
        playerState.track!.imageUri,
      );
      emit(AvailableDataHomeState(
        track: playerState.track!,
        isPaused: playerState.isPaused,
        image: image,
      ));
    }
  }

  @override
  Future<void> close() {
    _playerSubscription.cancel();
    return super.close();
  }
}
