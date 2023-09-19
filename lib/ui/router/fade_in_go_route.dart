import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// Route with fade in animation applied
class FadeInGoRoute extends GoRoute {
  FadeInGoRoute({
    required super.path,
    required final GoRouterWidgetBuilder builder,
  }) : super(
          pageBuilder: (final context, final state) {
            return CustomTransitionPage(
              child: builder(context, state),
              transitionsBuilder: (
                final BuildContext context,
                final Animation<double> animation,
                final Animation<double> secondaryAnimation,
                final Widget child,
              ) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            );
          },
        );
}
