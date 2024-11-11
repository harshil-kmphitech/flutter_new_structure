import 'package:get/get.dart';
import '../bindings/auth_binding.dart';
import '../ui/pages/login_page.dart';
import '../ui/pages/register_page.dart';
import '../ui/pages/forgot_password_page.dart';
import '../ui/pages/theme_page.dart';
import '../ui/pages/verify_code_page.dart';
import '../ui/pages/reset_password_page.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    // Login Page
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: AuthBinding(),
    ),
    // Registration Page
    GetPage(
      name: AppRoutes.register,
      page: () => RegisterPage(),
      binding: AuthBinding(),
    ),
    // Forgot Password Page
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgotPasswordPage(),
      binding: AuthBinding(),
    ),
    // Verification Code Page
    GetPage(
      name: AppRoutes.verifyCode,
      page: () => VerifyCodePage(),
      binding: AuthBinding(),
    ),
    // Reset Password Page
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => ResetPasswordPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.theme,
      page: () => const ThemePage(),
      binding: AuthBinding(),
    ),
  ];
}
