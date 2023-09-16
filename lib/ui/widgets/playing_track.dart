import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/home/bloc/home_bloc.dart';

const padding = 20.0;

class PlayingTrackWidget extends StatelessWidget {
  const PlayingTrackWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    var deltaY = 0.0;
    var deltaX = 0.0;

    final bloc = context.read<HomeBloc>();
    return GestureDetector(
      onVerticalDragUpdate: (final details) {
        // Calculate the vertical distance of the swipe
        final dy = details.primaryDelta ?? 0;
        if (dy.abs() > deltaY.abs()) deltaY = dy;
      },
      onVerticalDragEnd: (final details) {
        if (deltaY < 0) {
          bloc.add(SwipeGestureDetectedHomeEvent(Direction.up));
        } else if (deltaY > 0) {
          bloc.add(SwipeGestureDetectedHomeEvent(Direction.down));
        }
        deltaY = 0;
      },
      onHorizontalDragUpdate: (final details) {
        // Calculate the horizontal distance of the swipe
        final dx = details.primaryDelta ?? 0;
        if (dx.abs() > deltaX.abs()) deltaX = dx;
      },
      onHorizontalDragEnd: (final details) {
        if (deltaX < 0) {
          bloc.add(SwipeGestureDetectedHomeEvent(Direction.left));
        } else if (deltaX > 0) {
          bloc.add(SwipeGestureDetectedHomeEvent(Direction.right));
        }
        deltaX = 0;
      },
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ImageWidget(),
          SizedBox(height: 10),
          _TrackInfoWidget(),
          SizedBox(height: 20),
          _ControlsWidget(),
        ],
      ),
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
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
              image: image != null
                  ? DecorationImage(
                      image: MemoryImage(image),
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
            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            state.track.artists.map((final a) => a.name).join(', '),
            style: const TextStyle(fontSize: 30),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
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
