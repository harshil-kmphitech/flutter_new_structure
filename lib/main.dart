import 'package:app/app/routes/app_pages.dart';
import 'package:app/app/routes/app_routes.dart';
import 'package:app/app/utils/helpers/extensions/extensions.dart';
import 'package:app/app/utils/helpers/injectable/injectable.dart';
import 'package:app/app/utils/themes/app_theme.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// TODO: Change app name.
const _kAppName = 'APP_NAME';

void main() {
  configuration(myApp: const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: _kAppName,
      getPages: AppPages.routes,
      initialRoute: AppRoutes.splash,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(getIt<SharedPreferences>().getAppLocal ?? 'en'),

      ///Default Theme
      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      builder: EasyLoading.init(),
    );
  }
}
