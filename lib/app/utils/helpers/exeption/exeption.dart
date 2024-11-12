// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_structure/app/utils/constants/app_messages.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

@immutable
class UserFriendlyError {
  final String title;
  final String description;

  const UserFriendlyError(this.title, this.description);
}

extension DioExceptionTypeExtension on DioExceptionType {
  /// context should pass for incase app works with Localization so the context is required
  UserFriendlyError toUserFriendlyError() {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return const UserFriendlyError(
          "Connection Timeout",
          "Oops! It seems the connection timed out. Please check your internet connection and try again.",
        );
      case DioExceptionType.sendTimeout:
        return const UserFriendlyError(
          "Connection Timeout",
          "Oops! It seems the connection timed out. Please check your internet connection and try again.",
        );
      case DioExceptionType.receiveTimeout:
        return const UserFriendlyError(
          "Data Reception Issue",
          "Oops! We're having trouble receiving data right now. Please try again later.",
        );
      case DioExceptionType.badCertificate:
        return const UserFriendlyError(
          "Security Certificate Problem",
          "Sorry, there's a problem with the security certificate. Please contact support for assistance.",
        );
      case DioExceptionType.badResponse:
        return const UserFriendlyError(
          "Unexpected Server Response",
          "Oh no! We received an unexpected response from the server. Please try again later.",
        );
      case DioExceptionType.cancel:
        return const UserFriendlyError(
          "Request Cancelled",
          "Your request has been cancelled. Please try again.",
        );
      case DioExceptionType.connectionError:
        return const UserFriendlyError(
          "Connection Issue",
          "We're having trouble connecting to the server. Please check your internet connection and try again.",
        );
      case DioExceptionType.unknown:
      default:
        return const UserFriendlyError(
          "Unknown Error",
          "Oops! Something went wrong. Please try again later.",
        );
    }
  }
}

mixin class ApiHandler<T> {
  Future<void> handler(Future<T> request) async {
    try {
      state.value = LoadingState();
      final response = await request;
      state.value = SuccessState(response);
    } on DioExceptionType catch (e) {
      state.value = FailedState(
        isRetirable: switch (e) {
          DioExceptionType.connectionTimeout || DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout => true,
          _ => false,
        },
        error: e.toUserFriendlyError(),
      );
    }
  }

  Rx<ApiState> state = Rx(InitialState());
}

extension ApiHandlingExtension<T> on Future<T> {
  Future<void> handler(Rx<ApiState> state) async {
    try {
      state.value = LoadingState();
      final response = await this;
      state.value = SuccessState(response);
    } on DioExceptionType catch (e) {
      state.value = FailedState(
        isRetirable: switch (e) {
          DioExceptionType.connectionTimeout || DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout => true,
          _ => false,
        },
        error: e.toUserFriendlyError(),
      );
    } on DioException catch (e) {
      state.value = FailedState(
        isRetirable: switch (e.type) {
          DioExceptionType.connectionTimeout || DioExceptionType.sendTimeout || DioExceptionType.receiveTimeout => true,
          _ => false,
        },
        error: e.type.toUserFriendlyError(),
      );
    } catch (e) {
      state.value = FailedState(
        isRetirable: false,
        error: const UserFriendlyError(
          AppMessages.apiError,
          AppMessages.apiErrorDescription,
        ),
      );
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
