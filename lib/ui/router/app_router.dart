import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:logging/logging.dart';

import '../../business/models/minimal_notification.dart';
import '../modals/notifications/notification_modal_bottom_sheet.dart';
import '../pages/home/home_page.dart';
import '../pages/home/widgets/nav_bar/nav_bar_index.dart';
import '../pages/home/widgets/nav_bar/scaffold_with_nav_bar.dart';
import '../pages/notifications/notifications_page.dart';
import '../pages/settings/settings_page.dart';

/// The application router, used to navigate between pages and dialogs.
@singleton
class AppRouter extends GoRouter {
  /// A helper to generate a location string from a template.
  static String buildLocation(
    final String path,
    final Map<String, dynamic> pathParams,
  ) {
    assert(pathParams.isNotEmpty, 'parsing a path with empty params');

    final parsed = Uri.parse(path);
    return parsed
        .replace(
            pathSegments: parsed.pathSegments
                .map((final param) => pathParams[param] ?? param))
        .toString();
  }

  final _navBarIndexRoutes = {
    NavBarIndex.home: HomeRoute.buildLocation(),
    NavBarIndex.notifications: NotificationsRoute.buildLocation(),
    NavBarIndex.settings: SettingsRoute.buildLocation(),
  };

  AppRouter()
      : super(
          debugLogDiagnostics: kDebugMode,
          initialLocation: HomeRoute.buildLocation(),
          routes: [
            ScaffoldWithNavBarRoute(),
            // modals
            NotificationModalBottomSheet(),
          ],
          observers: [_LoggingNavigatorObserver()],
        );

  Future<void> showNotificationModal(
    final MinimalNotification notification,
  ) async =>
      push(NotificationModalBottomSheet.buildLocation(), extra: notification);

  void closeNotificationModal() => pop();

  void goToNavBarItemWithIndex(final NavBarIndex navBarIndex) {
    final route = _navBarIndexRoutes[navBarIndex];
    if (route == null) {
      throw Exception('No route for index $navBarIndex');
    }
    go(route);
  }
}

/// A navigator observer used to log navigation between pages.
class _LoggingNavigatorObserver extends NavigatorObserver {
  final _logger = Logger('$_LoggingNavigatorObserver');

  @override
  void didPush(
    final Route<dynamic> route,
    final Route<dynamic>? previousRoute,
  ) {
    _logger.info('entering $previousRoute -> $route');
  }

  @override
  void didPop(
    final Route<dynamic> route,
    final Route<dynamic>? previousRoute,
  ) {
    _logger.info('leaving $previousRoute -> $route');
  }
}
