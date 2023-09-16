import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/home/bloc/home_bloc.dart';
import 'dotted_icon.dart';

const padding = 20.0;

class PlayingTrackWidget extends StatelessWidget {
  const PlayingTrackWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ImageWidget(),
        _TrackInfoWidget(),
        SizedBox(height: 20),
        _ControlsWidget(),
      ],
    );
  }
}

/// Allows optimization of the image widget, reloading only it changes
class _ImageWidget extends StatelessWidget {
  static const imageSize = 450.0;

  const _ImageWidget();

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (final previous, final current) =>
          previous is AvailableDataHomeState &&
          current is AvailableDataHomeState &&
          previous.image != current.image,
      builder: (final context, final state) {
        final image = (state as AvailableDataHomeState).image;
        return Padding(
          padding: const EdgeInsets.all(padding),
          child: Container(
            height: imageSize,
            width: imageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: image != null
                  ? DecorationImage(
                      image: MemoryImage(image!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}

class _TrackInfoWidget extends StatelessWidget {
  const _TrackInfoWidget();

  @override
  Widget build(final BuildContext context) {
    final state = context.watch<HomeBloc>().state as AvailableDataHomeState;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            state.track.name,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            state.track.artist.name!,
            style: const TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}

class _ControlsWidget extends StatelessWidget {
  static const iconSize = 70.0;
  static const Color iconColor = Colors.black87;

  const _ControlsWidget();

  @override
  Widget build(final BuildContext context) {
    final bloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (final previous, final current) =>
          previous is AvailableDataHomeState &&
          current is AvailableDataHomeState &&
          previous.isPaused != current.isPaused,
      builder: (final context, final state) {
        final state = context.watch<HomeBloc>().state as AvailableDataHomeState;
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => bloc.add(SkipPreviousHomeEvent()),
                  icon: const Icon(
                    Icons.skip_previous,
                    size: iconSize,
                    color: iconColor,
                  ),
                ),
                state.isPaused
                    ? IconButton(
                        onPressed: () => bloc.add(PlayHomeEvent()),
                        icon: const Icon(
                          Icons.play_circle,
                          size: iconSize * 1.5,
                          color: iconColor,
                        ),
                      )
                    : IconButton(
                        onPressed: () => bloc.add(PauseHomeEvent()),
                        icon: const Icon(
                          Icons.pause_circle,
                          size: iconSize * 1.5,
                          color: iconColor,
                        ),
                      ),
                IconButton(
                  onPressed: () => bloc.add(SkipNextHomeEvent()),
                  icon: const Icon(
                    Icons.skip_next,
                    size: iconSize,
                    color: iconColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                state.isTrackInLibrary
                    ? IconButton(
                        onPressed: () => bloc.add(
                          RemoveTrackHomeEvent(state.track.uri),
                        ),
                        icon: const Icon(
                          Icons.favorite,
                          size: iconSize * 0.7,
                          color: iconColor,
                        ),
                      )
                    : IconButton(
                        onPressed: () => bloc.add(
                          SaveTrackHomeEvent(state.track.uri),
                        ),
                        icon: const Icon(
                          Icons.favorite_border,
                          size: iconSize * 0.7,
                          color: iconColor,
                        ),
                      ),
                IconButton(
                  onPressed: () => bloc.add(
                    ToggleShuffleHomeEvent(state.isShuffleEnabled),
                  ),
                  icon: state.isShuffleEnabled
                      ? const Icon(
                          Icons.shuffle,
                          size: iconSize * 0.7,
                          color: iconColor,
                        )
                      : const Icon(
                          Icons.shuffle_outlined,
                          size: iconSize * 0.7,
                          color: Colors.black45,
                        ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
