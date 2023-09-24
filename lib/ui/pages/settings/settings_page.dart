import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:settings_ui/settings_ui.dart';

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
    return SettingsList(
      contentPadding: const EdgeInsets.only(top: 50),
      sections: [
        SettingsSection(
          title: const Text('General'),
          tiles: [
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (final value) {},
              title: const Text('Turn on dark mode'),
              leading: const Icon(Icons.nightlight, size: 30),
            ),
          ],
        ),
        SettingsSection(
          tiles: [
            SettingsTile.switchTile(
              initialValue: false,
              onToggle: (final value) {},
              title: const Text('Activate Do Not Disturb while driving'),
              leading: const Icon(Icons.do_not_disturb_on, size: 30),
            ),
            SettingsTile.navigation(
              title: const Text('Allowed apps'),
              leading: const Icon(Icons.apps, size: 30),
            ),
          ],
          title: const Text('Notifications'),
        ),
      ],
    );
  }
}
