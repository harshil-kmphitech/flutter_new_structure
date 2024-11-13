// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/helpers/logger.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../utils/constants/app_strings.dart';

@immutable
class UserFriendlyError {
  final String title;
  final String description;

  const UserFriendlyError(this.title, this.description);
}

extension DioExceptionX on DioException {
  /// context should pass for incase app works with Localization so the context is required
  UserFriendlyError toUserFriendlyError() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return UserFriendlyError(
          AppStrings.T.connectionTimeout,
          AppStrings.T.connectionTimeoutDesc,
        );
      case DioExceptionType.sendTimeout:
        return UserFriendlyError(
          AppStrings.T.sendTimeout,
          AppStrings.T.sendTimeoutDesc,
        );
      case DioExceptionType.receiveTimeout:
        return UserFriendlyError(
          AppStrings.T.receiveTimeout,
          AppStrings.T.receiveTimeoutDesc,
        );
      case DioExceptionType.badCertificate:
        return UserFriendlyError(
          AppStrings.T.badCertificate,
          AppStrings.T.badCertificateDesc,
        );
      case DioExceptionType.badResponse:
        return UserFriendlyError(
          AppStrings.T.badResponse,
          _statusCode(response?.statusCode ?? 0),
        );
      case DioExceptionType.cancel:
        return UserFriendlyError(
          AppStrings.T.cancel,
          AppStrings.T.cancelDesc,
        );
      case DioExceptionType.connectionError:
        return UserFriendlyError(
          AppStrings.T.connectionError,
          AppStrings.T.connectionErrorDesc,
        );
      case DioExceptionType.unknown:
      default:
        return UserFriendlyError(
          AppStrings.T.unknown,
          AppStrings.T.unknownDesc,
        );
    }
  }

  String _statusCode(int? statusCode) {
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
  UserFriendlyError toUserFriendlyError() {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return UserFriendlyError(
          AppStrings.T.connectionTimeout,
          AppStrings.T.connectionTimeoutDesc,
        );
      case DioExceptionType.sendTimeout:
        return UserFriendlyError(
          AppStrings.T.sendTimeout,
          AppStrings.T.sendTimeoutDesc,
        );
      case DioExceptionType.receiveTimeout:
        return UserFriendlyError(
          AppStrings.T.receiveTimeout,
          AppStrings.T.receiveTimeoutDesc,
        );
      case DioExceptionType.badCertificate:
        return UserFriendlyError(
          AppStrings.T.badCertificate,
          AppStrings.T.badCertificateDesc,
        );
      case DioExceptionType.badResponse:
        return UserFriendlyError(
          AppStrings.T.badResponse,
          AppStrings.T.badResponseDesc,
        );
      case DioExceptionType.cancel:
        return UserFriendlyError(
          AppStrings.T.cancel,
          AppStrings.T.cancelDesc,
        );
      case DioExceptionType.connectionError:
        return UserFriendlyError(
          AppStrings.T.connectionError,
          AppStrings.T.connectionErrorDesc,
        );
      case DioExceptionType.unknown:
      default:
        return UserFriendlyError(
          AppStrings.T.unknown,
          AppStrings.T.unknownDesc,
        );
    }
  }
}

extension ApiHandlingExtension<T> on Future<T> {
  /// Must use handler it's a better way to handle request's response api calling
  Future<void> handler(Rx<ApiState> state, {ValueChanged<T>? onSuccess, ValueChanged<FailedState>? onFailed}) async {
    try {
      state.value = LoadingState();
      final response = await this;
      state.value = SuccessState<T>(response);
      onSuccess?.call(response);
    } on DioException catch (e) {
      state.value = FailedState(
        statusCode: e.response?.statusCode ?? 0,
        isRetirable: switch (e.type) {
          DioExceptionType.connectionTimeout || DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout => true,
          _ => false,
        },
        error: e.toUserFriendlyError(),
      );
      onFailed?.call(state.value as FailedState);
    } on Exception catch (e) {
      /// If you need more detailed information about exception so simply remove this catch
      /// after removing this catch you are able to see thrawed exception in debug console.
      e.log;
      state.value = FailedState(
        statusCode: 0,
        isRetirable: false,
        error: UserFriendlyError(
          AppStrings.T.apiError,
          AppStrings.T.apiErrorDescription,
        ),
      );
      onFailed?.call(state.value as FailedState);
    }
  }
}

extension ApiStateHelper on Rx<ApiState> {
  bool get isInitial => value is InitialState;
  bool get isLoading => value is LoadingState;
  bool get isSuccess => value is SuccessState;
  bool get isFailed => value is FailedState;
}

sealed class ApiState {
  static ApiState initial() => InitialState();
}

class SuccessState<T> extends ApiState {
  T value;
  SuccessState(this.value);
}

class InitialState extends ApiState {}

class LoadingState extends ApiState {}

class FailedState extends ApiState {
  bool isRetirable;
  UserFriendlyError error;

  int statusCode;

  FailedState({
    required this.isRetirable,
    required this.error,
    required this.statusCode,
  });
}
