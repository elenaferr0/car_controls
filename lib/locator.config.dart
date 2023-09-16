// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:car_controls/business/log_service.dart' as _i5;
import 'package:car_controls/business/spotify_remote_service.dart' as _i7;
import 'package:car_controls/repository/module.dart' as _i9;
import 'package:car_controls/repository/spotify_remote_repository.dart' as _i6;
import 'package:car_controls/ui/module.dart' as _i10;
import 'package:car_controls/ui/pages/home/bloc/home_bloc.dart' as _i8;
import 'package:flutter_dotenv/flutter_dotenv.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:keep_screen_on/keep_screen_on.dart' as _i4;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final repositoryModule = _$RepositoryModule();
    final uIModule = _$UIModule();
    await gh.singletonAsync<_i3.DotEnv>(
      () => repositoryModule.getDotenv(),
      preResolve: true,
    );
    await gh.factoryAsync<_i4.KeepScreenOn>(
      () => uIModule.keepScreenOn,
      preResolve: true,
    );
    gh.singleton<_i5.LogService>(
      _i5.LogService()..init(),
      dispose: (i) => i.dispose(),
    );
    gh.factory<String>(
      () => repositoryModule.getClientId(gh<_i3.DotEnv>()),
      instanceName: 'clientId',
    );
    gh.factory<String>(
      () => repositoryModule.getRedirectUrl(gh<_i3.DotEnv>()),
      instanceName: 'redirectUrl',
    );
    await gh.singletonAsync<_i6.SpotifyRemoteRepository>(
      () {
        final i = _i6.SpotifyRemoteRepository(
          gh<String>(instanceName: 'clientId'),
          gh<String>(instanceName: 'redirectUrl'),
        );
        return i.connect().then((_) => i);
      },
      preResolve: true,
    );
    gh.singleton<_i7.SpotifyRemoteService>(
        _i7.SpotifyRemoteService(gh<_i6.SpotifyRemoteRepository>()));
    gh.factory<_i8.HomeBloc>(
        () => _i8.HomeBloc(gh<_i7.SpotifyRemoteService>()));
    return this;
  }
}

class _$RepositoryModule extends _i9.RepositoryModule {}

class _$UIModule extends _i10.UIModule {}
