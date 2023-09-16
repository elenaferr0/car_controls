import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(fontFamily: 'Inter'),
    );
  }
}
