import 'dart:async';

import 'package:app/app/utils/helpers/injectable/injectable.config.dart';
import 'package:app/app/utils/helpers/loading.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart' as i;

final getIt = GetIt.instance;

@i.injectableInit
void configuration({required Widget myApp}) {
  if (kDebugMode) {
    _init(myApp);
    return;
  }

  runZonedGuarded(
    () {
      _init(myApp);
    },
    (error, stackTrace) => FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true),
    zoneSpecification: ZoneSpecification(
      handleUncaughtError:
          (Zone zone, ZoneDelegate delegate, Zone parent, Object error, StackTrace stackTrace) {
            FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
          },
    ),
  );
}

Future<void> _init(Widget myApp) async {
  WidgetsFlutterBinding.ensureInitialized();
  await getIt.init();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  Loading().configLoading();

  runApp(myApp);
}
