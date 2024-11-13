import 'package:flutter_new_structure/app/utils/helpers/all_imports.dart';

import '../../constants/app_strings.dart';

class AppValidations {
  static String? verificationCodeValidation(String? value) {
    if (value == null || value.isEmpty) return AppStrings.T.emptyVerificationCode;
    return null;
  }

  static String? phoneNumberValidation(String? value) {
    if (value == null || value.isEmpty) return AppStrings.T.emptyPhoneNumber;
    return null;
  }

  static String? nameValidation(String? value) {
    if (value == null || value.isEmpty) return AppStrings.T.emptyName;
    return null;
  }

  static String? passwordValidation(String? value) {
    if (value == null || value.isEmpty) return AppStrings.T.emptyPassword;
    return null;
  }

  static String? confirmPasswordValidation(String? value, String otherPasswordValue) {
    if (value == null || value.isEmpty) return AppStrings.T.emptyConfirmPassword;
    if (otherPasswordValue.isEmpty) return null;
    if (otherPasswordValue != value) return AppStrings.T.passwordMismatch;
    return null;
  }

  AppValidations._();
  static String? emailValidation(String? value) {
    if (value == null || value.isEmpty) return AppStrings.T.emptyEmail;
    if (!value.isEmail) return AppStrings.T.invalidEmail;
    return null;
  }
}
