// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:car_controls/business/log_service.dart' as _i6;
import 'package:car_controls/business/notifications_service.dart' as _i8;
import 'package:car_controls/business/spotify_remote_service.dart' as _i15;
import 'package:car_controls/business/volume_service.dart' as _i12;
import 'package:car_controls/repository/module.dart' as _i17;
import 'package:car_controls/repository/spotify_remote_repository.dart' as _i14;
import 'package:car_controls/repository/volume_repository.dart' as _i11;
import 'package:car_controls/ui/app_bloc.dart' as _i13;
import 'package:car_controls/ui/module.dart' as _i18;
import 'package:car_controls/ui/pages/home/bloc/home_bloc.dart' as _i16;
import 'package:car_controls/ui/pages/home/widgets/nav_bar/bloc/nav_bar_bloc.dart'
    as _i7;
import 'package:car_controls/ui/pages/settings/bloc/settings_bloc.dart' as _i9;
import 'package:car_controls/ui/router/app_router.dart' as _i3;
import 'package:flutter_dotenv/flutter_dotenv.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:keep_screen_on/keep_screen_on.dart' as _i5;
import 'package:volume_controller/volume_controller.dart' as _i10;

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
    gh.singleton<_i3.AppRouter>(_i3.AppRouter());
    await gh.singletonAsync<_i4.DotEnv>(
      () => repositoryModule.getDotenv(),
      preResolve: true,
    );
    await gh.factoryAsync<_i5.KeepScreenOn>(
      () => uIModule.keepScreenOn,
      preResolve: true,
    );
    gh.singleton<_i6.LogService>(
      _i6.LogService()..init(),
      dispose: (i) => i.dispose(),
    );
    gh.factory<_i7.NavBarBloc>(() => _i7.NavBarBloc(gh<_i3.AppRouter>()));
    await gh.singletonAsync<_i8.NotificationsService>(
      () {
        final i = _i8.NotificationsService();
        return i.initPlatformState().then((_) => i);
      },
      preResolve: true,
      dispose: (i) => i.stopListening(),
    );
    gh.factory<_i9.SettingsBloc>(() => _i9.SettingsBloc());
    gh.factory<String>(
      () => repositoryModule.getClientId(gh<_i4.DotEnv>()),
      instanceName: 'clientId',
    );
    gh.factory<String>(
      () => repositoryModule.getRedirectUrl(gh<_i4.DotEnv>()),
      instanceName: 'redirectUrl',
    );
    gh.singleton<_i10.VolumeController>(repositoryModule.getVolumeController());
    gh.singleton<_i11.VolumeRepository>(
        _i11.VolumeRepository(gh<_i10.VolumeController>()));
    await gh.singletonAsync<_i12.VolumeService>(
      () {
        final i = _i12.VolumeService(gh<_i11.VolumeRepository>());
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    await gh.factoryAsync<_i13.AppBloc>(
      () {
        final i = _i13.AppBloc(
          gh<_i8.NotificationsService>(),
          gh<_i3.AppRouter>(),
        );
        return i.init().then((_) => i);
      },
      preResolve: true,
    );
    gh.singleton<_i14.SpotifyRemoteRepository>(_i14.SpotifyRemoteRepository(
      gh<String>(instanceName: 'clientId'),
      gh<String>(instanceName: 'redirectUrl'),
    ));
    await gh.singletonAsync<_i15.SpotifyRemoteService>(
      () {
        final i = _i15.SpotifyRemoteService(gh<_i14.SpotifyRemoteRepository>());
        return i.connect().then((_) => i);
      },
      preResolve: true,
    );
    gh.factory<_i16.HomeBloc>(() => _i16.HomeBloc(
          gh<_i15.SpotifyRemoteService>(),
          gh<_i12.VolumeService>(),
        ));
    return this;
  }
}

class _$RepositoryModule extends _i17.RepositoryModule {}

class _$UIModule extends _i18.UIModule {}
