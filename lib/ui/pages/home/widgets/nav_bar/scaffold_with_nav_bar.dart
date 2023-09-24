import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../locator.dart';
import '../../../settings/settings_page.dart';
import '../../home_page.dart';
import 'bloc/nav_bar_bloc.dart';

class ScaffoldWithNavBarRoute extends ShellRoute {
  static final _routeIndex = <int, GoRoute>{
    0: HomeRoute(),
    1: SettingsRoute(),
  };

  ScaffoldWithNavBarRoute()
      : super(
          builder: _builder,
          routes: _routeIndex.values.toList(),
        );

  static Widget _builder(
    final BuildContext context,
    final GoRouterState state,
    final Widget child,
  ) =>
      BlocInjector<NavBarBloc>(child: _ScaffoldWithNavBarWidget(child: child));

  static String getPathWithIndex(final int index) =>
      _routeIndex[index]?.path ?? HomeRoute.buildLocation();
}

class _ScaffoldWithNavBarWidget extends StatelessWidget {
  final Widget child;

  const _ScaffoldWithNavBarWidget({required this.child});

  @override
  Widget build(final BuildContext context) {
    final bloc = context.watch<NavBarBloc>();
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bloc.state.currentIndex,
        onTap: (final index) {
          bloc.add(NavBarEventTabChanged(index: index));
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Spotify',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
