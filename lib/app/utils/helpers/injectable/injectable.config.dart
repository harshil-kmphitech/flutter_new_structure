// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app/app/controllers/app_controller.dart' as _i145;
import 'package:app/app/controllers/auth_controller.dart' as _i85;
import 'package:app/app/data/services/authService/auth_service.dart' as _i950;
import 'package:app/app/data/services/refreshToken/refresh_token_service.dart'
    as _i334;
import 'package:app/app/utils/helpers/injectable%20properties/injectable_properties.dart'
    as _i1019;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.pref(),
      preResolve: true,
    );
    await gh.factoryAsync<_i982.FirebaseApp>(
      () => registerModule.initializeFireBase(),
      preResolve: true,
    );
    gh.lazySingleton<_i145.AppController>(() => _i145.AppController());
    gh.lazySingleton<_i85.AuthController>(
      () => _i85.AuthController(),
      dispose: (i) => i.dispose(),
    );
    await gh.factoryAsync<String>(
      () => registerModule.getCurrentVersionCode(),
      instanceName: 'versioncode',
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(
      () => registerModule.dio(
        versionCode: gh<String>(instanceName: 'versioncode'),
      ),
    );
    gh.lazySingleton<_i334.RefreshTokenService>(
      () => _i334.RefreshTokenService.new(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i950.AuthService>(
      () => _i950.AuthService.new(gh<_i361.Dio>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i1019.RegisterModule {}
