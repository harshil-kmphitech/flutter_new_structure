import 'dart:io';

import 'package:app/app/global/app_config.dart';
import 'package:app/app/utils/helpers/Interceptor/curl_interceptor.dart';
import 'package:app/app/utils/helpers/Interceptor/dio_interceptor.dart';
import 'package:app/app/utils/helpers/Interceptor/response_interceptor.dart';
import 'package:app/firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:package_info_plus/package_info_plus.dart';
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
          AppDioInterceptor(),
          if (kDebugMode) ...[
            CurlInterceptor(printToConsole: false),
            ResponseLogInterceptor(printToConsole: false),
          ],
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
