import 'package:app/app/data/models/refreshToken/refresh_token_model.dart';
import 'package:app/app/data/services/refreshToken/refresh_token_service.dart';
import 'package:app/app/utils/helpers/exception/exception.dart';
import 'package:app/app/utils/helpers/extensions/extensions.dart';
import 'package:app/app/utils/helpers/injectable/injectable.dart';
import 'package:app/app/utils/helpers/loading.dart';
import 'package:app/app/utils/helpers/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide FormData;
import 'package:shared_preferences/shared_preferences.dart';

class QueueRequest<T> {
  QueueRequest({required this.err, required this.handler});

  final DioException err;

  final ErrorInterceptorHandler handler;

  void next() {
    handler.next(err);
  }

  Future<void> resolve() {
    final requestOptions = err.requestOptions;
    requestOptions.extra['new-Token'] = getIt<SharedPreferences>().getToken;
    return getIt<Dio>()
        .fetch(_recreate(requestOptions))
        .handler(
          null,
          isLoading: false,
          onSuccess: handler.resolve,
          onFailed: (value) {
            if (value.dioError != null) {
              debugPrintStack(
                stackTrace: value.dioError?.stackTrace,
                label: value.dioError?.response?.data.toString(),
              );
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
        ..files.addAll(data.files.map((e) => MapEntry(e.key, e.value.clone())));
    }

    return requestOptions.copyWith(data: data ?? requestOptions.data);
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
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    switch (err.response?.statusCode) {
      case 401 || 410:
        Loading.dismiss();
      // TODO: Write log out code here.
      case 433:
        _queueRequest(err, handler);
      case 426:
        _updateDialog();
      case 503:
      // TODO: Show App is under maintenance (screen | dialog | sheet).
      default:
        super.onError(err, handler);
    }
  }

  void _queueRequest(DioException err, ErrorInterceptorHandler handler) {
    requestQueue.add(QueueRequest(err: err, handler: handler));

    if (refreshTokenState.isInitial) {
      refreshToken();
    }
  }

  final refreshTokenState = RxApiState<RefreshTokenResponse>();

  Future<void> refreshToken() async {
    final data = getIt<SharedPreferences>().getUserId;
    if (data != null) {
      await getIt<RefreshTokenService>()
          .refreshToken(data)
          .handler(
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
    refreshTokenState.value = const InitialState();

    if (value.data.containsKey('token')) {
      pref.setToken = value.data['token'] as String;
      Future.wait(requestQueue.map((e) => e.resolve())).whenComplete(requestQueue.clear);
    } else {
      requestQueue
        ..forEach((element) => element.next())
        ..clear();

      return;
    }
  }

  void _updateDialog() {
    Loading.dismiss();
    Get.bottomSheet(
      const UpdateAppSheet(),
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
    ).ignore();
  }
}

class UpdateAppSheet extends StatelessWidget {
  const UpdateAppSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Design the Force Update App Sheet.
    return const PopScope(canPop: false, child: SizedBox());
  }
}
