// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/helpers/logger.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../constants/app_messages.dart';

@immutable
class UserFriendlyError {
  final String title;
  final String description;

  const UserFriendlyError(this.title, this.description);
}

extension DioExceptionTypeX on DioExceptionType {
  /// context should pass for incase app works with Localization so the context is required
  UserFriendlyError toUserFriendlyError() {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return const UserFriendlyError(
          AppMessages.connectionTimeout,
          AppMessages.connectionTimeoutDesc,
        );
      case DioExceptionType.sendTimeout:
        return const UserFriendlyError(
          AppMessages.sendTimeout,
          AppMessages.sendTimeoutDesc,
        );
      case DioExceptionType.receiveTimeout:
        return const UserFriendlyError(
          AppMessages.receiveTimeout,
          AppMessages.receiveTimeoutDesc,
        );
      case DioExceptionType.badCertificate:
        return const UserFriendlyError(
          AppMessages.badCertificate,
          AppMessages.badCertificateDesc,
        );
      case DioExceptionType.badResponse:
        return const UserFriendlyError(
          AppMessages.badResponse,
          AppMessages.badResponseDesc,
        );
      case DioExceptionType.cancel:
        return const UserFriendlyError(
          AppMessages.cancel,
          AppMessages.cancelDesc,
        );
      case DioExceptionType.connectionError:
        return const UserFriendlyError(
          AppMessages.connectionError,
          AppMessages.connectionErrorDesc,
        );
      case DioExceptionType.unknown:
      default:
        return const UserFriendlyError(
          AppMessages.unknown,
          AppMessages.unknownDesc,
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
        isRetirable: switch (e.type) {
          DioExceptionType.connectionTimeout || DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout => true,
          _ => false,
        },
        error: e.type.toUserFriendlyError(),
      );
      onFailed?.call(state.value as FailedState);
    } on Exception catch (e) {
      /// If you need more detailed information about exception so simply remove this catch
      /// after removing this catch you are able to see thrawed exception in debug console.
      e.log;
      state.value = FailedState(
        isRetirable: false,
        error: const UserFriendlyError(
          AppMessages.apiError,
          AppMessages.apiErrorDescription,
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

  FailedState({
    required this.isRetirable,
    required this.error,
  });
}
