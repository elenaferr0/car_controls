import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../locator.dart';
import '../../router/fade_in_go_route.dart';
import 'bloc/notifications_bloc.dart';

class NotificationsRoute extends FadeInGoRoute {
  static const String _path = '/notifications';

  static String buildLocation() => _path;

  NotificationsRoute() : super(path: _path, builder: _builder);

  static Widget _builder(
    final BuildContext context,
    final GoRouterState state,
  ) =>
      BlocInjector<NotificationsBloc>(child: const _NotificationsPageWidget());
}

class _NotificationsPageWidget extends StatelessWidget {
  const _NotificationsPageWidget();

  @override
  Widget build(final BuildContext context) {
    return const Center(child: Text('Notifications'));
  }
}
