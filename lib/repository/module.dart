import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:volume_controller/volume_controller.dart';

@module
abstract class RepositoryModule {
  @singleton
  @preResolve
  Future<DotEnv> getDotenv() async {
    await dotenv.load(fileName: '.env');
    return dotenv;
  }

  @singleton
  VolumeController getVolumeController() => VolumeController();

  @Named('clientId')
  String getClientId(final DotEnv dotenv) => dotenv.env['CLIENT_ID']!;

  @Named('redirectUrl')
  String getRedirectUrl(final DotEnv dotenv) => dotenv.env['REDIRECT_URL']!;
}
