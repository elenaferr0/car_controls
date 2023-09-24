import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../locator.dart';
import '../../router/fade_in_go_route.dart';
import 'bloc/settings_bloc.dart';

class SettingsRoute extends FadeInGoRoute {
  static const _path = '/settings';

  static String buildLocation() => _path;

  SettingsRoute() : super(path: _path, builder: _builder);

  static Widget _builder(
    final BuildContext context,
    final GoRouterState state,
  ) {
    return BlocInjector<SettingsBloc>(child: const _SettingsPage());
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage();

  @override
  Widget build(final BuildContext context) {
    return const Center(
      child: Text('Settings'),
    );
  }
}
