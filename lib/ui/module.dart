import 'package:injectable/injectable.dart';
import 'package:keep_screen_on/keep_screen_on.dart';

@module
abstract class UIModule {
  @preResolve
  Future<KeepScreenOn> get keepScreenOn async {
    await KeepScreenOn.turnOn();
    return KeepScreenOn();
  }
}