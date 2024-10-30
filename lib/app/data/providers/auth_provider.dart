import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_new_structure/app/global/app_config.dart';
import 'package:flutter_new_structure/app/routes/app_routes.dart';
import 'package:flutter_new_structure/app/services/exeption.dart';
import 'package:flutter_new_structure/app/utils/helpers/http_status_codes.dart';
import 'package:flutter_new_structure/app/utils/helpers/logger.dart';
import 'package:http/http.dart' as http;

import '../../utils/constants/app_messages.dart';
import '../../utils/constants/json_keys.dart';
import '../models/auth_model.dart';

class AuthProvider {
  final String baseUrl = AppConfig.baseUrl;

  // Login API call
  Future<AuthModel?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl${AppRoutes.login}');
    Logger.log('Making POST request to: $url with email: $email');

    try {
      // Set timeout duration
      final response = await http.post(
        url,
        body: {
          JsonKeys.email: email,
          JsonKeys.password: password,
        },
      ).timeout(const Duration(milliseconds: AppConfig.timeoutDuration));

      Logger.log('Response status: ${response.statusCode}');
      Logger.log('Response body: ${response.body}');

      if (response.statusCode == HttpStatusCodes.ok) {
        return AuthModel.fromJson(jsonDecode(response.body));
      } else {
        Logger.logError('Login failed with status: ${response.statusCode}');
        throw Exception(AppMessages.loginFailed);
      }
    } catch (error, stackTrace) {
      Logger.logError('Error during login', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  // Registration API call
  Future<AuthModel?> register(AuthModel authModel) async {
    final url = Uri.parse('$baseUrl${AppRoutes.register}');
    Logger.log('Making POST request to: $url with user data: ${authModel.toJson()}');

    try {
      final response = await http
          .post(
            url,
            body: authModel.toJson(),
          )
          .timeout(const Duration(milliseconds: AppConfig.timeoutDuration));

      Logger.log('Response status: ${response.statusCode}');
      Logger.log('Response body: ${response.body}');

      if (response.statusCode == HttpStatusCodes.ok) {
        return AuthModel.fromJson(jsonDecode(response.body));
      } else {
        Logger.logError('Registration failed with status: ${response.statusCode}');
        throw Exception(AppMessages.registerFailed);
      }
    } catch (error, stackTrace) {
      Logger.logError('Error during registration', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  // Forgot Password API call
  Future<void> forgotPassword(String email) async {
    final url = Uri.parse('$baseUrl${AppRoutes.forgotPassword}');
    Logger.log('Making POST request to: $url with email: $email');

    try {
      final response = await http.post(
        url,
        body: {JsonKeys.email: email},
      ).timeout(const Duration(milliseconds: AppConfig.timeoutDuration));

      Logger.log('Response status: ${response.statusCode}');

      if (response.statusCode != HttpStatusCodes.ok) {
        Logger.logError('Forgot password request failed with status: ${response.statusCode}');
        throw Exception(AppMessages.passwordResetFailed);
      }
    } catch (error, stackTrace) {
      Logger.logError('Error during forgot password request', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  // Reset Password API call
  Future<void> resetPassword(String email, String newPassword) async {
    final url = Uri.parse('$baseUrl${AppRoutes.resetPassword}');
    Logger.log('Making POST request to: $url with email: $email');

    try {
      final response = await http.post(
        url,
        body: {
          JsonKeys.email: email,
          JsonKeys.newPassword: newPassword,
        },
      ).timeout(const Duration(milliseconds: AppConfig.timeoutDuration));

      Logger.log('Response status: ${response.statusCode}');

      if (response.statusCode != HttpStatusCodes.ok) {
        Logger.logError('Password reset failed with status: ${response.statusCode}');
        throw Exception(AppMessages.passwordResetFailed);
      }
    } catch (error, stackTrace) {
      Logger.logError('Error during password reset', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  // Verify Code API call
  Future<void> verifyCode(String email, String code) async {
    final url = Uri.parse('$baseUrl${AppRoutes.verifyCode}');
    Logger.log('Making POST request to: $url with email: $email and code: $code');

    try {
      final response = await http.post(
        url,
        body: {
          JsonKeys.email: email,
          JsonKeys.code: code,
        },
      ).timeout(const Duration(milliseconds: AppConfig.timeoutDuration));

      Logger.log('Response status: ${response.statusCode}');

      if (response.statusCode != HttpStatusCodes.ok) {
        Logger.logError('Code verification failed with status: ${response.statusCode}');
        throw Exception(AppMessages.codeVerificationFailed);
      }
    } catch (error, stackTrace) {
      Logger.logError('Error during code verification', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}

class APIFunction {
  Future<dynamic> apiCall({
    required Future<dynamic> Function() request,
    bool isShowSnackbar = true,
  }) async {
    try {
      return await request();
    } on DioException catch (err) {
      if (isShowSnackbar) {
        // showSnackBar(message: err.type.toUserFriendlyError().description);
      }
      return null;
    }
  }
}

sealed class ApiState {}

class LoadingState extends ApiState {}

class FailedState extends ApiState {
  final UserFriendlyError error;
  FailedState(this.error);
}

class SuccessState extends ApiState {}
