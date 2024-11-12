import 'package:flutter_new_structure/app/utils/constants/app_messages.dart';
import 'package:flutter_new_structure/app/utils/helpers/all_imports.dart';

class AppValidations {
  static String? verificationCodeValidation(String? value) {
    if (value == null || value.isEmpty) return AppMessages.emptyVerificationCode;
    return null;
  }

  static String? phoneNumberValidation(String? value) {
    if (value == null || value.isEmpty) return AppMessages.emptyPhoneNumber;
    return null;
  }

  static String? nameValidation(String? value) {
    if (value == null || value.isEmpty) return AppMessages.emptyName;
    return null;
  }

  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) return AppMessages.emptyPassword;
    return null;
  }

  static String? confirmPasswordValidation(String? value, String otherPasswordValue) {
    if (value == null || value.isEmpty) return AppMessages.emptyConfirmPassword;
    if (otherPasswordValue.isEmpty) return null;
    if (otherPasswordValue != value) return AppMessages.passwordMismatch;
    return null;
  }

  AppValidations._();
  static String? emailValidation(String? value) {
    if (value == null || value.isEmpty) return AppMessages.emptyEmail;
    if (!value.isEmail) return AppMessages.invalidEmail;
    return null;
  }
}
