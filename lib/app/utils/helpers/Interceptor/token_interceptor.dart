import 'package:dio/dio.dart';
import 'package:flutter_new_structure/app/data/models/authModel/auth_model.dart';
import 'package:flutter_new_structure/app/data/services/refreshToken/refresh_token_service.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/exporter.dart' hide Response;
import 'package:flutter_new_structure/app/utils/helpers/extensions/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kTokenExpireCode = 9;

class QueueRequest<T> {
  QueueRequest({
    required this.response,
    required this.handler,
  });

  final Response<T> response;

  final ResponseInterceptorHandler handler;

  void next() {
    handler.next(response);
  }

  Future<void> resolve() {
    final requestOptions = response.requestOptions;
    requestOptions.extra['new-Token'] = getIt<SharedPreferences>().getToken;
    return getIt<Dio>().fetch(_recreateOptions(requestOptions)).handler(
      null,
      isLoading: false,
      onSuccess: handler.resolve,
      onFailed: (value) {
        if (value.dioError != null) {
          debugPrintStack(stackTrace: value.dioError?.stackTrace, label: value.dioError?.response?.data.toString());
          handler.reject(value.dioError!);
        } else {
          handler.next(response);
        }
      },
    );
  }

  static RequestOptions _recreateOptions(RequestOptions options) {
    return RequestOptions(
      headers: {
        ...options.headers,
      },
      data: options.data,
      baseUrl: options.baseUrl,
      path: options.path,
      cancelToken: options.cancelToken,
      connectTimeout: options.connectTimeout,
      sendTimeout: options.sendTimeout,
      receiveTimeout: options.receiveTimeout,
      receiveDataWhenStatusError: options.receiveDataWhenStatusError,
      followRedirects: options.followRedirects,
      maxRedirects: options.maxRedirects,
      validateStatus: options.validateStatus,
      onReceiveProgress: options.onReceiveProgress,
      onSendProgress: options.onSendProgress,
      contentType: options.contentType,
      responseType: options.responseType,
      extra: options.extra,
      method: options.method,
      queryParameters: options.queryParameters,
    );
  }
}

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor();

  final List<QueueRequest<dynamic>> requestQueue = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = getIt<SharedPreferences>().getToken;

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    if (options.extra.containsKey('new-Token')) {
      options.extra['new-Token'].toString().log;
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (response.data?['ResponseCode'] == 6 || response.data?['responseCode'] == 6) {
      _queueRequest(response, handler);
    } else {
      super.onResponse(response, handler);
    }
  }

  void _queueRequest(Response<dynamic> response, ResponseInterceptorHandler handler) {
    requestQueue.add(
      QueueRequest(
        response: response,
        handler: handler,
      ),
    );

    if (refreshTokenState is InitialState) {
      refreshToken();
    }
  }

  ApiState refreshTokenState = ApiState.initial();

  Future<void> refreshToken() async {
    final pref = getIt<SharedPreferences>()..setToken = null;
    final userId = pref.getUserId;

    if (userId != null) {
      await getIt<RefreshTokenService>().refreshToken(userId).handler(
            null,
            isLoading: false,
            onSuccess: _onRefreshSuccess,
            onFailed: _rejectQueuedRequests,
          );
    } else {
      requestQueue
        ..forEach((element) => element.next())
        ..clear();
    }
  }

  void _rejectQueuedRequests(FailedState<dynamic> value) {
    for (final element in requestQueue) {
      element.next();
    }
    requestQueue.clear();
  }

  void _onRefreshSuccess(RefreshTokenResponse value) {
    final pref = getIt<SharedPreferences>();

    if (value.data.containsKey('token')) {
      pref.setToken = value.data['token'] as String;
    } else {
      requestQueue
        ..forEach((element) => element.next())
        ..clear();

      return;
    }
    refreshTokenState = InitialState();

    Future.wait(
      requestQueue.map((e) => e.resolve()),
    ).whenComplete(requestQueue.clear);
  }
}

extension on MultipartFile {
  MultipartFile recreate() {
    return MultipartFile.fromStream(
      finalize,
      length,
      contentType: contentType,
      filename: filename,
      headers: headers,
    );
  }
}
