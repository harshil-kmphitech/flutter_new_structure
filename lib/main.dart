import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_new_structure/app/utils/helpers/extensions/extensions.dart';
import 'package:flutter_new_structure/app/utils/helpers/injectable/injectable.dart';
import 'package:flutter_new_structure/app/utils/helpers/logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'app/utils/themes/app_theme.dart';

void main() {
  configuration(
    myApp: const MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      // minTextAdapt: true,
      enableScaleText: () => false,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        FlutterNativeSplash.remove();
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'FLUTTER STRUCTURE',
          getPages: AppPages.routes,
          scrollBehavior: CustomScrollBehavior(),
          initialRoute: AppRoutes.login,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(getIt<SharedPreferences>().getAppLocal ?? 'en'),

          ///Default Theme
          themeMode: ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }

  @override
  void initState() {
    _preCacheAssets();
    super.initState();
  }

  Future<void> _preCacheAssets() async {
    var manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    var assets = manifest.listAssets();

    var listOfPng = assets.where((element) => element.endsWith('.png')).map((e) => precacheImage(AssetImage(e), context, onError: _onError));
    var listOfSvg = assets.where((element) => element.endsWith('.svg')).map((e) => SvgAssetLoader(e));

    await Future.wait([
      ...listOfPng,
      ...listOfSvg.map((e) => e.loadBytes(context)),
    ]);

    if (mounted) {
      for (var e in listOfSvg) {
        e.cacheKey(context);
      }
    }
  }

  void _onError(Object exception, StackTrace? stackTrace) {
    if (kDebugMode) {
      exception.logWithName('precacheImageError');
    }
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics(); // Set your desired physics here
  }

  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child; // Return the child without any effects
  }
}
