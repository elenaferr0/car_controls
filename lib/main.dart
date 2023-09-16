import 'package:flutter/cupertino.dart';

import 'locator.dart';
import 'ui/app.dart';

void main() async {
  await buildDependencyGraph();
  runApp(const App());
}