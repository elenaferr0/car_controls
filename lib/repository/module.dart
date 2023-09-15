import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RepositoryModule {
  @singleton
  @preResolve
  Future<DotEnv> getDotenv() async {
    await dotenv.load(fileName: '.env');
    return dotenv;
  }

  @Named('clientId')
  String getClientId(DotEnv dotenv) => dotenv.env['CLIENT_ID']!;

  @Named('redirectUrl')
  String getRedirectUrl(DotEnv dotenv) => dotenv.env['REDIRECT_URL']!;
}