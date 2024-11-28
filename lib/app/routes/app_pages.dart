import 'package:demo/app/routes/app_routes.dart';
import 'package:demo/app/ui/pages/authentication/forgot_password_page.dart';
import 'package:demo/app/ui/pages/authentication/login_page.dart';
import 'package:demo/app/ui/pages/authentication/register_page.dart';
import 'package:demo/app/ui/pages/authentication/reset_password_page.dart';
import 'package:demo/app/ui/pages/authentication/verify_code_page.dart';
import 'package:demo/app/ui/pages/theme/theme_page.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    // Login Page
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
    ),
    // Registration Page
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterPage(),
    ),
    // Forgot Password Page
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordPage(),
    ),
    // Verification Code Page
    GetPage(
      name: AppRoutes.verifyCode,
      page: () => const VerifyCodePage(),
    ),
    // Reset Password Page
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordPage(),
    ),
    GetPage(
      name: AppRoutes.theme,
      page: () => const ThemePage(),
    ),
  ];
}
