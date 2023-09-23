import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../locator.dart';
import '../../modals/notifications/bloc/notifications_bloc.dart';
import '../../router/fade_in_go_route.dart';
import '../../widgets/playing_track.dart';
import 'bloc/home_bloc.dart';

class HomeRoute extends FadeInGoRoute {
  static const String _path = '/';

  static String buildLocation() => _path;

  HomeRoute() : super(path: _path, builder: _builder);

  static Widget _builder(
    final BuildContext context,
    final GoRouterState state,
  ) =>
      BlocInjector<HomeBloc>(
        child: BlocInjector<NotificationsBloc>(
          child: const _HomeWidget(),
        ),
      );
}

class _HomeWidget extends StatelessWidget {
  const _HomeWidget();

  @override
  Widget build(final BuildContext context) {
    // to be removed, needed for notifications bloc to work
    context.watch<NotificationsBloc>();
    return Scaffold(
      body: Center(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (final context, final state) => switch (state) {
            NoDataHomeState() => const Text('No data'),
            LoadingHomeState() => const CircularProgressIndicator(),
            AvailableDataHomeState() => const PlayingTrackWidget(),
            _ => const Center(child: Text('Unknown state')),
          },
        ),
      ),
    );
  }
}
