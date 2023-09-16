import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../pages/home/bloc/home_bloc.dart';

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
        if (image == null) {
          return const CircularProgressIndicator();
        } else {
          // image with border radius
          return Padding(
            padding: const EdgeInsets.all(padding),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.memory(
                  image,
                  fit: BoxFit.cover,
                  // errorBuilder: (final context, final error, final stackTrace) {
                  //   bloc.add(NoDataHomeState());
                  //   return const Icon(Icons.error);
                  // },
                )),
          );
        }
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
  static const iconSize = 65.0;

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
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () => bloc.add(SkipPreviousHomeEvent()),
              icon: const Icon(Icons.skip_previous, size: iconSize),
            ),
            state.isPaused
                ? IconButton(
                    onPressed: () => bloc.add(PlayHomeEvent()),
                    icon: const Icon(Icons.play_circle, size: iconSize * 1.5),
                  )
                : IconButton(
                    onPressed: () => bloc.add(PauseHomeEvent()),
                    icon: const Icon(Icons.pause_circle, size: iconSize * 1.5),
                  ),
            IconButton(
              onPressed: () => bloc.add(SkipNextHomeEvent()),
              icon: const Icon(Icons.skip_next, size: iconSize),
            ),
          ],
        );
      },
    );
  }
}
