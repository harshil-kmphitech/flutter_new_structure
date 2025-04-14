import 'package:dio/dio.dart';
import 'package:flutter_new_structure/app/data/models/authModel/auth_model.dart';
import 'package:flutter_new_structure/app/data/services/refreshToken/refresh_token_service.dart';
import 'package:flutter_new_structure/app/utils/helpers/exception/exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/exporter.dart'
    hide Response;
import 'package:flutter_new_structure/app/utils/helpers/extensions/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QueueRequest<T> {
  QueueRequest({
    required this.err,
    required this.handler,
  });

  final DioException err;

  final ErrorInterceptorHandler handler;

  void next() {
    handler.next(err);
  }

  Future<void> resolve() {
    final requestOptions = err.requestOptions;
    requestOptions.extra['new-Token'] = getIt<SharedPreferences>().getToken;
    return getIt<Dio>().fetch(_recreate(requestOptions)).handler(
      null,
      isLoading: false,
      onSuccess: handler.resolve,
      onFailed: (value) {
        if (value.dioError != null) {
          debugPrintStack(
              stackTrace: value.dioError?.stackTrace,
              label: value.dioError?.response?.data.toString());
          handler.reject(value.dioError!);
        } else {
          handler.next(err);
        }
      },
    );
  }

  RequestOptions _recreate(RequestOptions requestOptions) {
    FormData? data;
    if (requestOptions.data is FormData) {
      data = requestOptions.data as FormData;
      data = FormData()
        ..fields.addAll(data.fields)
        ..files.addAll(
          data.files.map(
            (e) => MapEntry(
              e.key,
              e.value.clone(),
            ),
          ),
        );
    }

    return requestOptions.copyWith(
      data: data ?? requestOptions.data,
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
    options.headers['lang'] = getIt<SharedPreferences>().getAppLocal ?? 'en';

    if (options.extra.containsKey('new-Token')) {
      options.extra['new-Token'].toString().log;
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      Loading.dismiss();
      // TODO: Write log out code here.
    } else if (err.response?.statusCode == 433) {
      _queueRequest(err, handler);
    } else {
      super.onError(err, handler);
    }
  }

  void _queueRequest(DioException err, ErrorInterceptorHandler handler) {
    requestQueue.add(
      QueueRequest(
        err: err,
        handler: handler,
      ),
    );

    if (refreshTokenState.isInitial) {
      refreshToken();
    }
  }

  final refreshTokenState = ApiState.initial();

  Future<void> refreshToken() async {
    final data = getIt<SharedPreferences>().getUserId;
    if (data != null) {
      await getIt<RefreshTokenService>().refreshToken(data).handler(
            refreshTokenState,
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
    refreshTokenState.value = InitialState();

    Future.wait(
      requestQueue.map((e) => e.resolve()),
    ).whenComplete(requestQueue.clear);
  }
}
