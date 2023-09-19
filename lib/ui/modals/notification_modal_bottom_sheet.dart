import 'package:flutter/material.dart';

import '../router/modal_bottom_sheet_route.dart';

class NotificationModalBottomSheet extends ModalBottomSheetGoRoute {
  static const String _path = '/modals/notifications';

  static String buildLocation() => _path;

  NotificationModalBottomSheet() : super(path: _path, builder: _builder);

  static Widget _builder(final _, final __) =>
      const _NotificationModalBottomSheetWidget();
}

class _NotificationModalBottomSheetWidget extends StatelessWidget {
  const _NotificationModalBottomSheetWidget();

  @override
  Widget build(final BuildContext context) {
    return const SizedBox(
        height: 300,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Notifications'),
            SizedBox(height: 20),
            Text('Coming soon...'),
          ],
        ));
  }
}
