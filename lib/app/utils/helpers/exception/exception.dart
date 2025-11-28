import 'dart:async';

import 'package:app/app/ui/widgets/custom_snack_bar.dart';
import 'package:app/app/utils/constants/app_strings.dart';
import 'package:app/app/utils/helpers/loading.dart';
import 'package:app/app/utils/helpers/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData, MultipartFile, Response;

part 'rx_api_state_x.dart';

@immutable
class UserFriendlyError {
  const UserFriendlyError(this.title, this.description);
  final String title;
  final String description;
}

extension DioExceptionX on DioException {
  /// context should pass for incase app works with Localization so the context is required
  UserFriendlyError toUserFriendlyError() {
    return type.toUserFriendlyError(badResponseDesc: _statusCode(response?.statusCode));
  }

  String _statusCode(int? statusCode) {
    final res = response?.data;
    if (res is Map<String, dynamic>) {
      if (res.containsKey('message')) {
        return '${res['message']}';
      }
    }
    return switch (statusCode) {
      200 => AppStrings.T.code200,
      201 => AppStrings.T.code201,
      202 => AppStrings.T.code202,
      301 => AppStrings.T.code301,
      302 => AppStrings.T.code302,
      304 => AppStrings.T.code304,
      400 => AppStrings.T.code400,
      401 => AppStrings.T.code401,
      403 => AppStrings.T.code403,
      404 => AppStrings.T.code404,
      405 => AppStrings.T.code405,
      409 => AppStrings.T.code409,
      500 => AppStrings.T.code500,
      503 => AppStrings.T.code503,
      _ => AppStrings.T.badResponseDesc,
    };
  }
}

extension DioExceptionTypeX on DioExceptionType {
  /// context should pass for incase app works with Localization so the context is required
  UserFriendlyError toUserFriendlyError({String? badResponseDesc}) {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return UserFriendlyError(AppStrings.T.sendTimeout, AppStrings.T.sendTimeoutDesc);
      case DioExceptionType.sendTimeout:
        return UserFriendlyError(AppStrings.T.sendTimeout, AppStrings.T.sendTimeoutDesc);
      case DioExceptionType.receiveTimeout:
        return UserFriendlyError(AppStrings.T.receiveTimeout, AppStrings.T.receiveTimeoutDesc);
      case DioExceptionType.badCertificate:
        return UserFriendlyError(AppStrings.T.badCertificate, AppStrings.T.badCertificateDesc);
      case DioExceptionType.badResponse:
        return UserFriendlyError(
          AppStrings.T.badResponse,
          badResponseDesc ?? AppStrings.T.badResponseDesc,
        );
      case DioExceptionType.cancel:
        return UserFriendlyError(AppStrings.T.reqCancel, AppStrings.T.reqCancelDesc);
      case DioExceptionType.connectionError:
        return UserFriendlyError(AppStrings.T.connectionError, AppStrings.T.connectionErrorDesc);
      case DioExceptionType.unknown:
        return UserFriendlyError(AppStrings.T.unknown, AppStrings.T.unknownDesc);
    }
  }
}

typedef ApiSuccessCallback<T> = void Function(T value);

typedef ApiFailedCallback<T> = void Function(FailedState<T> value);

extension ApiHandlingX<T> on Future<T> {
  /// Must use handler it's a better way to handle request's response api calling
  /// Must use handler it's a better way to handle request's response api calling
  Future<void> handler(
    Rx<ApiState<T>>? state, {
    bool isLoading = true,
    bool includeResponseInSuccessState = false,
    ApiSuccessCallback<T>? onSuccess,
    ApiFailedCallback<T>? onFailed,
  }) async {
    try {
      state?.value = LoadingState();
      if (isLoading) Loading.show();

      final response = await this;

      state?.value = SuccessState<T>(includeResponseInSuccessState ? response : null);
      onSuccess?.call(response);
    } on DioException catch (e) {
      final failedState = FailedState<T>(
        statusCode: e.response?.statusCode ?? 0,
        isRetirable: switch (e.type) {
          DioExceptionType.connectionError ||
          DioExceptionType.connectionTimeout ||
          DioExceptionType.sendTimeout ||
          DioExceptionType.receiveTimeout => true,
          _ => false,
        },
        dioError: e,
      );

      state?.value = failedState;
      onFailed?.call((state?.value ?? failedState) as FailedState<T>);
    } catch (e) {
      e.log;
      final failedState = FailedState<T>(statusCode: 0, isRetirable: false, dioError: null);

      state?.value = failedState;
      onFailed?.call((state?.value ?? failedState) as FailedState<T>);
    } finally {
      if (isLoading) Loading.dismiss();
    }
  }
}
