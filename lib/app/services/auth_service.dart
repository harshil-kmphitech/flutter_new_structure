import 'package:flutter_new_structure/app/data/models/auth_model.dart';
import 'package:flutter_new_structure/app/data/repositories/auth_repository.dart';
import '../utils/constants/app_messages.dart';
import 'package:get/get.dart';

class AuthService {
  final AuthRepository _authRepository = Get.put(AuthRepository());

  // Login function
  Future<AuthModel?> login(String email, String password) async {
    try {
      AuthModel? user = await _authRepository.login(email, password);
      if (user != null) {
        // Optionally perform any business logic, e.g., caching the user data
        return user;
      } else {
        throw Exception(AppMessages.loginFailed);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Registration function
  Future<AuthModel?> register(AuthModel newUser) async {
    try {
      AuthModel? user = await _authRepository.register(newUser);
      if (user != null) {
        return user;
      } else {
        throw Exception(AppMessages.registerFailed);
      }
    } catch (e) {
      rethrow;
    }
  }

  // Forgot password function
  Future<void> forgotPassword(String email) async {
    try {
      await _authRepository.forgotPassword(email);
    } catch (e) {
      throw Exception(AppMessages.passwordResetFailed);
    }
  }

  // Reset password function
  Future<void> resetPassword(String email, String newPassword) async {
    try {
      await _authRepository.resetPassword(email, newPassword);
    } catch (e) {
      throw Exception(AppMessages.passwordResetFailed);
    }
  }

  // Verify code function
  Future<void> verifyCode(String email, String code) async {
    try {
      await _authRepository.verifyCode(email, code);
    } catch (e) {
      throw Exception(AppMessages.codeVerificationFailed);
    }
  }
}
