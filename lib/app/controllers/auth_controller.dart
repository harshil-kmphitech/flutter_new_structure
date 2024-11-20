import 'package:flutter_new_structure/app/data/models/authModel/auth_model.dart';
import 'package:flutter_new_structure/app/data/services/authService/auth_service.dart';
import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/utils/constants/app_strings.dart';
import 'package:flutter_new_structure/app/utils/helpers/all_imports.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/extensions/extensions.dart';
import 'package:flutter_new_structure/app/utils/helpers/injectable/injectable.dart';
import 'package:injectable/injectable.dart' as i;

void _disposeAuthController(AuthController instance) {
  instance.dispose();
}

@i.LazySingleton(dispose: _disposeAuthController)
@i.injectable
class AuthController extends GetxController {
  bool isDarkTheme = false;

  // Observable variables for user input
  TextEditingController emailController = TextEditingController();
  TextEditingController forgotEmailController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController registerPassController = TextEditingController();
  TextEditingController resetPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController verificationCode = TextEditingController();

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
  void login(BuildContext context) {
    if (!Form.of(context).validate()) {
      return;
    }

    getIt<AuthService>().login(emailController.text, passController.text.convertMd5).handler(
      loginState,
      onSuccess: (value) {
        if (value != null) {
          authModel.value = value;
          showSuccess(authModel.value!.ResponseMsg);
          Get.offNamed(AppRoutes.theme);
        }
      },
      onFailed: (value) {
        // If the onFailed is called that means your ApiState has FailedState value
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
          Get.toNamed(AppRoutes.verifyCode);
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
        if (value?.ResponseCode == 1) {
          authModel.value = value;
          showSuccess(AppStrings.T.registerSuccess);
          Get.offAllNamed(AppRoutes.theme);
        } else {
          showError(value?.ResponseMsg ?? AppStrings.T.registerFailed);
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
          Get.toNamed(AppRoutes.verifyCode);
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
        if (value.ResponseCode == 1) {
          showSuccess(AppStrings.T.passwordResetSuccess);
          Get
            ..closeAllSnackbars()
            ..offAllNamed(AppRoutes.theme);
        } else {
          showError(value.ResponseMsg);
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
          Get.offNamed(AppRoutes.resetPassword);
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
