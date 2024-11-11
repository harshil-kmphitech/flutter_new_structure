import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
