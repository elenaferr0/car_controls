import 'package:flutter_bloc/flutter_bloc.dart';

import 'router/app_router.dart';
import 'package:flutter/material.dart';
import '../locator.dart';
import 'app_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(final BuildContext context) =>
      BlocInjector<AppBloc>(child: const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(final BuildContext context) {
    context.watch<AppBloc>();
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
