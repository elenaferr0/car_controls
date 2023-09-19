import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModalBottomSheetGoRoute extends GoRoute {
  ModalBottomSheetGoRoute({
    required super.path,
    required final GoRouterWidgetBuilder builder,
  }) : super(
          pageBuilder: (final context, final state) {
            return _NotificationModalPage(
              builder: (final context) => builder(context, state),
            );
          },
        );
}

class _NotificationModalPage<T> extends Page<T> {
  final Offset? anchorPoint;
  final Color? barrierColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;

  const _NotificationModalPage({
    required this.builder,
    this.anchorPoint,
    this.barrierColor = Colors.black54,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(final BuildContext context) => ModalBottomSheetRoute<T>(
        builder: builder,
        isDismissible: barrierDismissible,
        barrierLabel: barrierLabel,
        enableDrag: false,
        isScrollControlled: true,
        settings: this,
      );
}
