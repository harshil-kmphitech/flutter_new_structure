import 'package:app/app/data/models/refreshToken/refresh_token_model.dart';
import 'package:app/app/utils/helpers/exception/exception.dart';
import 'package:app/app/utils/helpers/extensions/extensions.dart';
import 'package:app/app/utils/helpers/injectable/injectable.dart';
import 'package:app/app/utils/helpers/loading.dart';
import 'package:app/app/utils/helpers/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'core.dart';

class AppDioInterceptor extends _CoreInterceptor {
  AppDioInterceptor();

  /// TODO: You must call this in the application's starting point while the user is logged in.
  static void resetAllFlags() {
    _CoreInterceptor._isLoggedOut = false;
    _CoreInterceptor._isUpdateDialogShown = false;
    _CoreInterceptor._isMaintenanceModeShown = false;
  }

  @override
  // TODO: Write token provider code here.
  String? get _tokenProvider => null;

  @override
  Future<void> onUnauthorized() async {
    // TODO: Write log out code here.
  }

  @override
  void onUpdateDialog() {
    // TODO: Write update dialog code here.
  }

  @override
  void showMaintenanceMode() {
    // TODO: Write show maintenance mode code here.
  }

  @override
  Future<void> saveNewRefreshedToken(RefreshTokenResponse value) async {
    // TODO: Write save new refreshed token code here.
  }

  @override
  bool lookForTokenInResponse(RefreshTokenResponse value) {
    return value.data.containsKey('token');
  }

  @override
  /// Must return the refresh token response from the api call.
  Future<RefreshTokenResponse>? refreshApiCall() {
    // TODO: Write refresh api call code here.
    return null;
  }
}
