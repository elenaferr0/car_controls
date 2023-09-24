import 'package:car_controls/ui/router/app_router.dart';
import 'package:flutter/material.dart';
import '../locator.dart';
import 'modals/notifications/bloc/notifications_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(final BuildContext context) =>
      BlocInjector<NotificationsBloc>(child: const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        colorSchemeSeed: Colors.indigo,
        iconTheme: const IconThemeData(size: 70),
      ),
      routerConfig: locator<AppRouter>(),
    );
  }
}
