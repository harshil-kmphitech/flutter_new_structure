// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:io' as _i497;

import 'package:dio/dio.dart' as _i361;
import 'package:firebase_core/firebase_core.dart' as _i982;
import 'package:flutter_new_structure/app/controllers/auth_controller.dart'
    as _i289;
import 'package:flutter_new_structure/app/data/services/auth_service.dart'
    as _i535;
import 'package:flutter_new_structure/app/utils/helpers/injectable%20properties/injectable_properties.dart'
    as _i854;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.pref(),
      preResolve: true,
    );
    await gh.factoryAsync<_i497.Directory>(
      () => registerModule.temporaryDirectory(),
      preResolve: true,
    );
    await gh.factoryAsync<_i982.FirebaseApp>(
      () => registerModule.initializeFireBase(),
      preResolve: true,
    );
    gh.singleton<_i361.Dio>(() => registerModule.dio());
    gh.lazySingleton<_i289.AuthController>(() => _i289.AuthController());
    gh.lazySingleton<_i854.AppDirectory>(
        () => _i854.AppDirectory(temporaryDirectory: gh<_i497.Directory>()));
    gh.lazySingleton<_i535.AuthService>(
        () => _i535.AuthService(gh<_i361.Dio>()));
    return this;
  }
}

class _$RegisterModule extends _i854.RegisterModule {}
