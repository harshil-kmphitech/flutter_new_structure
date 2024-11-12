import 'dart:async';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_new_structure/app/utils/helpers/Intercepter/token_intercepter.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart' as i;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../cache/cache_options.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@i.injectableInit
Future<void> configuration({required void Function() runApp}) async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await getIt.init();
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
      FlutterError.onError = (errorDetails) => FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      getIt<Dio>().interceptors
        ..add(TokenInterceptor(dio: getIt<Dio>()))
        ..add(PrettyDioLogger(responseBody: false))
        ..add(DioCacheInterceptor(options: cacheOption))
        ..add(RetryInterceptor(dio: getIt<Dio>()));

      runApp();
    },
    (error, stackTrace) => FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true),
    zoneSpecification: ZoneSpecification(
      handleUncaughtError: (Zone zone, ZoneDelegate delegate, Zone parent, Object error, StackTrace stackTrace) {
        FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
      },
    ),
  );
}
