import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_new_structure/app/data/models/authModel/auth_model.dart';
import 'package:flutter_new_structure/app/data/services/authService/auth_service.dart';
import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/ui/pages/authentication/reset_password_page.dart';
import 'package:flutter_new_structure/app/ui/pages/authentication/verify_code_page.dart';
import 'package:flutter_new_structure/app/ui/pages/theme/theme_page.dart';
import 'package:flutter_new_structure/app/utils/constants/app_strings.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/extensions/extensions.dart';
import 'package:flutter_new_structure/app/utils/helpers/injectable/injectable.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart' as i;

@i.lazySingleton
@i.injectable
class AuthController extends GetxController {
  AuthController() {
    onInit();
  }

  bool isDarkTheme = false;
  bool isDarkTheme1 = false;

  // Observable variables for user input
  final emailController = TextEditingController(text: kDebugMode ? 'mayur.kmphasis@gmail.com' : null);
  final forgotEmailController = TextEditingController();
  final registerEmailController = TextEditingController();
  final passController = TextEditingController(text: kDebugMode ? 'User@123' : null);
  final registerPassController = TextEditingController();
  final resetPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final verificationCode = TextEditingController();

  final loginState = ApiState.initial().obs;
  final forgotState = ApiState.initial().obs;
  final resetPassState = ApiState.initial().obs;
  final registerState = ApiState.initial().obs;
  final verificationState = ApiState.initial().obs;

  // State variables for loading and model
  Rxn<AuthModel> authModel = Rxn<AuthModel>();

  // Helper method to display success messages
  void showSuccess(String message) {
    Get.snackbar('Success', message);
  }

  // Helper method to display error messages
  void showError(String message) {
    Get.snackbar('Error', message);
  }

  // Login method
  Future<void> login(BuildContext context) async {
    if (!Form.of(context).validate()) {
      return;
    }
    loginState.value = LoadingState();
    await getIt<AuthService>()
        .login(
      emailController.text,
      passController.text,
      deviceToken: await getIt<FirebaseMessaging>().getToken() ?? '',
      deviceType: switch (Platform.operatingSystem) {
        'android' => 'Android',
        'ios' => 'iOS',
        _ => 'Other',
      },
    )
        .handler(
      loginState,
      isLoading: false,
      onSuccess: (value) {
        authModel.value = value;
        showSuccess(authModel.value!.message);
        ThemePage.offAllRoute();
      },
      onFailed: (value) {
        showError(value.error.description);
      },
    );
  }

  void sendOtp(BuildContext context) {
    if (!Form.of(context).validate()) {
      return;
    }

    getIt<AuthService>()
        .sendOTP(
      registerEmailController.text,
      nameController.text,
    )
        .handler(
      registerState,
      onSuccess: (value) {
        if (value.data['ResponseCode'] == 1) {
          showSuccess(value.data['ResponseMsg'].toString());
          verificationCode.clear();
          VerifyCodePage.route();
        } else {
          showError(AppStrings.T.registerFailed);
        }
      },
      onFailed: (value) {
        showError(AppStrings.T.registerFailed);
      },
    );
  }

  // Registration method
  void register(BuildContext context) {
    if (!Form.of(context).validate()) {
      return;
    }

    getIt<AuthService>()
        .register(
      email: registerEmailController.text,
      pass: registerPassController.text.convertMd5,
      phone: phoneNumberController.text,
      name: nameController.text,
      ccode: '+91',
      role: 'Student',
      otp: verificationCode.text,
    )
        .handler(
      registerState,
      onSuccess: (value) {
        if (value.statusCode == 200) {
          authModel.value = value;
          showSuccess(AppStrings.T.registerSuccess);
          ThemePage.offAllRoute();
        } else {
          showError(value.message);
        }
      },
      onFailed: (value) {
        showError(value.error.description);
      },
    );
  }

  // Forgot password method
  void forgotPassword(BuildContext context) {
    if (!Form.of(context).validate()) {
      return;
    }

    getIt<AuthService>().forgotPassword(forgotEmailController.text).handler(
      forgotState,
      onSuccess: (value) {
        if (value.data['ResponseCode'] == 1) {
          showSuccess(AppStrings.T.passwordResetEmailSent);
          verificationCode.clear();
          VerifyCodePage.route();
        } else {
          showError(value.data['ResponseMsg'].toString());
        }
      },
      onFailed: (value) {
        showError(value.error.description);
      },
    );
  }

  // Reset password method with password match validation
  void resetPassword(BuildContext context) {
    if (!Form.of(context).validate()) {
      return;
    }
    getIt<AuthService>().resetPassword(forgotEmailController.text, resetPassController.text.convertMd5).handler(
      resetPassState,
      onSuccess: (value) {
        if (value.statusCode == 200) {
          showSuccess(AppStrings.T.passwordResetSuccess);
          Get.closeAllSnackbars();
          ThemePage.offAllRoute();
        } else {
          showError(value.message);
        }
      },
      onFailed: (value) {
        showError(value.error.description);
      },
    );
  }

  // Verify code method
  void verifyCode(BuildContext context) {
    if (!Form.of(context).validate()) return;
    if (Get.previousRoute == AppRoutes.register) {
      return register(context);
    }
    getIt<AuthService>().verifyCode(forgotEmailController.text, verificationCode.text).handler(
      verificationState,
      onSuccess: (value) {
        if (value.data['ResponseCode'] == 1) {
          showSuccess(AppStrings.T.codeVerificationSuccess);
          ResetPasswordPage.route();
        } else {
          showError(value.data['ResponseMsg'].toString());
        }
      },
      onFailed: (value) {
        showError(value.error.description);
      },
    );
  }

  @override
  @i.disposeMethod
  void dispose() {
    super.dispose();
    emailController.dispose();
    forgotEmailController.dispose();
    registerEmailController.dispose();
    passController.dispose();
    registerPassController.dispose();
    resetPassController.dispose();
    confirmPassController.dispose();
    nameController.dispose();
    phoneNumberController.dispose();
    verificationCode.dispose();
    loginState.close();
    forgotState.close();
    resetPassState.close();
    registerState.close();
    verificationState.close();
    authModel.close();
    // isDarkTheme.close();
  }
}
