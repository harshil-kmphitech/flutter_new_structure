import 'package:dio/dio.dart';
import 'package:flutter_new_structure/app/data/models/auth_model.dart';
import 'package:flutter_new_structure/app/data/services/auth_service.dart';
import 'package:flutter_new_structure/app/utils/helpers/all_imports.dart';
import 'package:flutter_new_structure/app/utils/helpers/injectable/injectable.dart';
import 'package:injectable/injectable.dart' as i;

import '../utils/constants/app_messages.dart';
import '../utils/helpers/exeption/exeption.dart';

@i.lazySingleton
@i.injectable
class AuthController extends GetxController {
  final AuthService _authService = getIt<AuthService>();

  var isDarkTheme = false.obs;

  // Observable variables for user input
  var emailController = TextEditingController();
  var forgotEmailController = TextEditingController();
  var registerEmailController = TextEditingController();
  var passController = TextEditingController();
  var registerPassController = TextEditingController();
  var resetPassController = TextEditingController();
  var confirmPassController = TextEditingController();
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var verificationCode = TextEditingController();

  final loginState = ApiState.initial().obs;
  final forgotState = ApiState.initial().obs;
  final resetPassState = ApiState.initial().obs;
  final registerState = ApiState.initial().obs;
  final verificationState = ApiState.initial().obs;

  // State variables for loading and model
  var authModel = Rxn<AuthModel>();

  // Helper method to display success messages
  void showSuccess(String message) {
    Get.snackbar("Success", message);
  }

  // Helper method to display error messages
  void showError(String message) {
    Get.snackbar("Error", message);
  }

  // Login method
  Future<void> login(BuildContext context) async {
    if (!Form.of(context).validate()) return;

    _authService.login(emailController.text, passController.text).handler(loginState).whenComplete(
      () {
        switch (loginState.value) {
          case SuccessState e:
            if (e.value != null) {
              authModel.value = e.value;
              showSuccess(AppMessages.loginSuccess);
              break;
            }
          case FailedState e:
            if (e.isRetirable) {
              showError(e.error.description);
              break;
            }
          default:
            showError(AppMessages.loginFailed);
        }
      },
    );
  }

  // Registration method
  Future<void> register(BuildContext context) async {
    if (!Form.of(context).validate()) return;
    AuthModel newUser = AuthModel(
      name: nameController.text,
      email: registerEmailController.text,
      password: passController.text,
      phoneNumber: phoneNumberController.text,
    );
    _authService.register(newUser).handler(registerState).whenComplete(
      () {
        switch (loginState.value) {
          case SuccessState e:
            if (e.value != null) {
              authModel.value = e.value;
              showSuccess(AppMessages.registerSuccess);
              break;
            }
          case FailedState e:
            if (e.isRetirable) {
              showError(e.error.description);
              break;
            }
          default:
            showError(AppMessages.registerFailed);
        }
      },
    );
  }

  // Forgot password method
  Future<void> forgotPassword(BuildContext context) async {
    if (!Form.of(context).validate()) return;

    _authService.forgotPassword(forgotEmailController.text).handler(forgotState).whenComplete(
      () {
        switch (loginState.value) {
          case SuccessState e:
            if (e.value != null) {
              authModel.value = e.value;
              showSuccess(AppMessages.passwordResetEmailSent);
              break;
            }
          case FailedState e:
            if (e.isRetirable) {
              showError(e.error.description);
              break;
            }
          default:
            showError(AppMessages.passwordResetFailed);
        }
      },
    );
  }

  // Reset password method with password match validation
  Future<void> resetPassword(BuildContext context) async {
    if (!Form.of(context).validate()) return;
    _authService
        .resetPassword(
          forgotEmailController.text,
          resetPassController.text,
          Options(
            sendTimeout: const Duration(minutes: 2),
          ),
        )
        .handler(resetPassState)
        .whenComplete(() {
      switch (loginState.value) {
        case SuccessState e:
          if (e.value != null) {
            authModel.value = e.value;
            showSuccess(AppMessages.passwordResetSuccess);
            break;
          }
        case FailedState e:
          if (e.isRetirable) {
            showError(e.error.description);
            break;
          }
        default:
          showError(AppMessages.passwordResetFailed);
      }
    });
  }

  // Verify code method
  Future<void> verifyCode(BuildContext context) async {
    if (!Form.of(context).validate()) return;
    _authService.verifyCode(forgotEmailController.text, verificationCode.text).handler(verificationState).whenComplete(
      () {
        switch (loginState.value) {
          case SuccessState e:
            if (e.value != null) {
              authModel.value = e.value;
              showSuccess(AppMessages.codeVerificationSuccess);
              break;
            }
          case FailedState e:
            if (e.isRetirable) {
              showError(e.error.description);
              break;
            }
          default:
            showError(AppMessages.codeVerificationFailed);
        }
      },
    );
  }
}
