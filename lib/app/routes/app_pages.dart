import 'package:app/app/routes/app_routes.dart';
import 'package:app/app/ui/pages/splash_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = <GetPage<dynamic>>[
    GetPage(name: AppRoutes.splash, page: () => const SplashPage()),
  ];
}
