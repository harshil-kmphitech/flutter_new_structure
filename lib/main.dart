import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_new_structure/app/routes/app_pages.dart';
import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/utils/helpers/extensions/extensions.dart';
import 'package:flutter_new_structure/app/utils/helpers/injectable/injectable.dart';
import 'package:flutter_new_structure/app/utils/helpers/logger.dart';
import 'package:flutter_new_structure/app/utils/themes/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    FlutterNativeSplash.remove();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FLUTTER STRUCTURE',
      getPages: AppPages.routes,
      initialRoute: AppRoutes.login,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(getIt<SharedPreferences>().getAppLocal ?? 'en'),

      ///Default Theme
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      builder: EasyLoading.init(),
    );
  }

  @override
  void initState() {
    _preCacheAssets();
    super.initState();
  }

  Future<void> _preCacheAssets() async {
    final manifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assets = manifest.listAssets();

    final listOfPng = assets.where((element) => element.endsWith('.png')).map((e) => precacheImage(AssetImage(e), context, onError: _onError));
    final listOfSvg = assets.where((element) => element.endsWith('.svg')).map(SvgAssetLoader.new);

    await Future.wait([
      ...listOfPng,
      ...listOfSvg.map((e) => e.loadBytes(context)),
    ]);

    if (mounted) {
      for (final e in listOfSvg) {
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
