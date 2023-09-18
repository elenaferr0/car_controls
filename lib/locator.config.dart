// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:car_controls/business/log_service.dart' as _i5;
import 'package:car_controls/business/notifications_service.dart' as _i6;
import 'package:car_controls/business/spotify_remote_service.dart' as _i11;
import 'package:car_controls/business/volume_service.dart' as _i9;
import 'package:car_controls/repository/module.dart' as _i13;
import 'package:car_controls/repository/spotify_remote_repository.dart' as _i10;
import 'package:car_controls/repository/volume_repository.dart' as _i8;
import 'package:car_controls/ui/module.dart' as _i14;
import 'package:car_controls/ui/pages/home/bloc/home_bloc.dart' as _i12;
import 'package:flutter_dotenv/flutter_dotenv.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:keep_screen_on/keep_screen_on.dart' as _i4;
import 'package:volume_controller/volume_controller.dart' as _i7;

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
    await gh.singletonAsync<_i6.NotificationsService>(
      () {
        final i = _i6.NotificationsService();
        return i.initPlatformState().then((_) => i);
      },
      preResolve: true,
      dispose: (i) => i.stopListening(),
    );
    gh.factory<String>(
      () => repositoryModule.getClientId(gh<_i3.DotEnv>()),
      instanceName: 'clientId',
    );
    gh.factory<String>(
      () => repositoryModule.getRedirectUrl(gh<_i3.DotEnv>()),
      instanceName: 'redirectUrl',
    );
    gh.singleton<_i7.VolumeController>(repositoryModule.getVolumeController());
    gh.singleton<_i8.VolumeRepository>(
        _i8.VolumeRepository(gh<_i7.VolumeController>()));
    await gh.singletonAsync<_i9.VolumeService>(
      () {
        final i = _i9.VolumeService(gh<_i8.VolumeRepository>());
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.singleton<_i10.SpotifyRemoteRepository>(_i10.SpotifyRemoteRepository(
      gh<String>(instanceName: 'clientId'),
      gh<String>(instanceName: 'redirectUrl'),
    ));
    await gh.singletonAsync<_i11.SpotifyRemoteService>(
      () {
        final i = _i11.SpotifyRemoteService(gh<_i10.SpotifyRemoteRepository>());
        return i.connect().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<_i12.HomeBloc>(() => _i12.HomeBloc(
          gh<_i11.SpotifyRemoteService>(),
          gh<_i9.VolumeService>(),
        ));
    return this;
  }
}

class _$RepositoryModule extends _i13.RepositoryModule {}

class _$UIModule extends _i14.UIModule {}
