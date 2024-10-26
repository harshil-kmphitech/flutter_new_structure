import 'package:flutter_new_structure/app/utils/constants/app_messages.dart';
import '../../utils/helpers/logger.dart';
import '../models/auth_model.dart';
import '../providers/auth_provider.dart';

class AuthRepository {
  final AuthProvider _authProvider = AuthProvider();

  // Method for logging in the user
  Future<AuthModel?> login(String email, String password) async {
    try {
      Logger.log('Attempting login for email: $email');
      final authModel = await _authProvider.login(email, password);
      Logger.log('Login successful for email: $email');
      return authModel;
    } catch (error) {
      Logger.logError(AppMessages.loginFailed, error: error);
      rethrow; // Rethrow to pass error handling back to the service/controller
    }
  }

  // Method for registering a new user
  Future<AuthModel?> register(AuthModel newUser) async {
    try {
      Logger.log('Attempting registration for email: ${newUser.email}');
      final authModel = await _authProvider.register(newUser);
      Logger.log('Registration successful for email: ${newUser.email}');
      return authModel;
    } catch (error) {
      Logger.logError(AppMessages.registerFailed, error: error);
      rethrow;
    }
  }

  // Method for sending a password reset link
  Future<void> forgotPassword(String email) async {
    try {
      Logger.log('Sending password reset link to email: $email');
      await _authProvider.forgotPassword(email);
      Logger.log('Password reset link sent to email: $email');
    } catch (error) {
      Logger.logError(AppMessages.passwordResetFailed, error: error);
      rethrow;
    }
  }

  // Method for resetting the user's password
  Future<void> resetPassword(String email, String newPassword) async {
    try {
      Logger.log('Attempting to reset password for email: $email');
      await _authProvider.resetPassword(email, newPassword);
      Logger.log('Password reset successful for email: $email');
    } catch (error) {
      Logger.logError(AppMessages.passwordResetFailed, error: error);
      rethrow;
    }
  }

  // Method for verifying the authentication code
  Future<void> verifyCode(String email, String code) async {
    try {
      Logger.log('Attempting code verification for email: $email');
      await _authProvider.verifyCode(email, code);
      Logger.log('Code verification successful for email: $email');
    } catch (error) {
      Logger.logError(AppMessages.codeVerificationFailed, error: error);
      rethrow;
    }
  }
}
