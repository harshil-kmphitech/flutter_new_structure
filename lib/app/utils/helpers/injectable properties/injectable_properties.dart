import 'dart:io';

import 'package:app/app/global/app_config.dart';
import 'package:app/app/utils/helpers/Interceptor/token_interceptor.dart';
import 'package:app/app/utils/helpers/logger.dart';
import 'package:app/firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @singleton
  Dio dio({@Named('versioncode') required String versionCode}) =>
      Dio(
          BaseOptions(
            sendTimeout: AppConfig.sendTimeout,
            receiveTimeout: AppConfig.receiveTimeout,
            connectTimeout: AppConfig.connectTimeout,
            headers: {
              'versioncode': versionCode,
              'devicetype': switch (Platform.operatingSystem) {
                'android' => 'android',
                'ios' => 'iOS',
                _ => 'Other',
              },
            },
          ),
        )
        ..interceptors.addAll([
          RefreshTokenInterceptor(),
          if (kDebugMode)
            PrettyDioLogger(
              requestHeader: true,
              requestBody: true,
              logPrint: (object) => object.log,
            ),
        ]);

  @preResolve
  Future<SharedPreferences> pref() => SharedPreferences.getInstance();

  @preResolve
  Future<FirebaseApp> initializeFireBase() =>
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  @preResolve
  @Named('versioncode')
  Future<String> getCurrentVersionCode() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return (Platform.isAndroid ? packageInfo.buildNumber : packageInfo.version);
  }
}
