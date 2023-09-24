import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../locator.dart';
import '../../../settings/settings_page.dart';
import '../../home_page.dart';
import 'bloc/nav_bar_bloc.dart';
import 'nav_bar_index.dart';

class ScaffoldWithNavBarRoute extends ShellRoute {
  ScaffoldWithNavBarRoute()
      : super(builder: _builder, routes: [
          HomeRoute(),
          SettingsRoute(),
        ]);

  static Widget _builder(
    final BuildContext context,
    final GoRouterState state,
    final Widget child,
  ) =>
      BlocInjector<NavBarBloc>(child: _ScaffoldWithNavBarWidget(child: child));
}

class _ScaffoldWithNavBarWidget extends StatelessWidget {
  final Widget child;

  const _ScaffoldWithNavBarWidget({required this.child});

  @override
  Widget build(final BuildContext context) {
    final bloc = context.watch<NavBarBloc>();
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: bloc.state.currentIndex.value,
        height: 90,
        onDestinationSelected: (final index) => bloc.add(
          NavBarEventTabChanged(selectedIndex: NavBarIndex.fromInt(index)),
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.music_note_outlined, size: 30),
            selectedIcon: Icon(Icons.music_note, size: 30),
            label: 'Spotify',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, size: 30),
            selectedIcon: Icon(Icons.settings, size: 30),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
