import 'package:flutter_new_structure/app/data/models/auth_model.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../utils/constants/app_messages.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();

  // Observable variables for user input
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var name = ''.obs;
  var phoneNumber = ''.obs;
  var verificationCode = ''.obs;
  
  // State variables for loading and model
  var isLoading = false.obs;
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
  Future<void> login() async {
    isLoading.value = true;
    try {
      authModel.value = await _authService.login(email.value, password.value);
      if (authModel.value != null) {
        showSuccess(AppMessages.loginSuccess);
      }
    } catch (e) {
      // Display generic error message for login failure
      showError(AppMessages.loginFailed);
    } finally {
      isLoading.value = false;
    }
  }

  // Registration method
  Future<void> register() async {
    isLoading.value = true;
    try {
      // Create a new AuthModel instance with user input
      AuthModel newUser = AuthModel(
        name: name.value,
        email: email.value,
        password: password.value,
        phoneNumber: phoneNumber.value,
      );
      authModel.value = await _authService.register(newUser);
      showSuccess(AppMessages.registerSuccess);
    } catch (e) {
      // Display generic error message for registration failure
      showError(AppMessages.registerFailed);
    } finally {
      isLoading.value = false;
    }
  }

  // Forgot password method
  Future<void> forgotPassword() async {
    isLoading.value = true;
    try {
      await _authService.forgotPassword(email.value);
      showSuccess(AppMessages.passwordResetEmailSent);
    } catch (e) {
      // Display generic error message for forgot password failure
      showError(AppMessages.passwordResetFailed);
    } finally {
      isLoading.value = false;
    }
  }

  // Reset password method with password match validation
  Future<void> resetPassword() async {
    isLoading.value = true;
    try {
      if (password.value == confirmPassword.value) {
        await _authService.resetPassword(email.value, password.value);
        showSuccess(AppMessages.passwordResetSuccess);
      } else {
        // Display error if passwords do not match
        showError(AppMessages.passwordMismatch);
      }
    } catch (e) {
      showError(AppMessages.passwordResetFailed);
    } finally {
      isLoading.value = false;
    }
  }

  // Verify code method
  Future<void> verifyCode() async {
    isLoading.value = true;
    try {
      await _authService.verifyCode(email.value, verificationCode.value);
      showSuccess(AppMessages.codeVerificationSuccess);
    } catch (e) {
      showError(AppMessages.codeVerificationFailed);
    } finally {
      isLoading.value = false;
    }
  }
}
