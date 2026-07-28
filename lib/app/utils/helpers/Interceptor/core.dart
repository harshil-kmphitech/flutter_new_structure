part of 'dio_interceptor.dart';

class QueueRequest<T> {
  QueueRequest({required this.err, required this.handler});

  final DioException err;

  final ErrorInterceptorHandler handler;

  void next() {
    handler.next(err);
  }

  Future<void> resolve() {
    final requestOptions = err.requestOptions;
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

abstract class _CoreInterceptor extends Interceptor with _CoreInterceptorImpl {
  final List<QueueRequest<dynamic>> requestQueue = [];

  static bool _isLoggedOut = false;
  static bool _isUpdateDialogShown = false;
  static bool _isMaintenanceModeShown = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_tokenProvider case final String token) {
      if (token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token'.log;
      }
    }

    options.headers['lang'] = _langProvider;

    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    switch (err.response?.statusCode) {
      case 401 || 410:
        if (!_isLoggedOut) {
          _isLoggedOut = true;
          await _onUnauthorized();
        }
        super.onError(err, handler);
      case 426:
        if (!_isUpdateDialogShown) {
          _isUpdateDialogShown = true;
          _updateDialog();
        }
        _ignoreError(err, handler);
      case 433:
        _queueRequest(err, handler);
      case 503:
        if (!_isMaintenanceModeShown) {
          _isMaintenanceModeShown = true;
          _showMaintenanceMode();
        }
        _ignoreError(err, handler);
      default:
        super.onError(err, handler);
    }
  }

  void _queueRequest(DioException err, ErrorInterceptorHandler handler) {
    requestQueue.add(QueueRequest(err: err, handler: handler));

    if (!refreshTokenState.isLoading) {
      refreshToken();
    }
  }

  final refreshTokenState = RxApiState<RefreshTokenResponse>();

  void refreshToken() {
    if (refreshApiCall() case final Future<RefreshTokenResponse> refreshApiCall) {
      refreshApiCall.handler(
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

  Future<RefreshTokenResponse>? refreshApiCall();

  Future<void> _rejectQueuedRequests(FailedState<dynamic> value) async {
    requestQueue
      ..forEach((element) => element.next())
      ..clear();
  }

  Future<void> _onRefreshSuccess(RefreshTokenResponse value) async {
    if (lookForTokenInResponse(value)) {
      await saveNewRefreshedToken(value);
      Future.wait(requestQueue.map((e) => e.resolve())).whenComplete(requestQueue.clear).ignore();
    } else {
      requestQueue
        ..forEach((element) => element.next())
        ..clear();
    }
  }

  void _ignoreError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(IgnoreDioException(requestOptions: err.requestOptions), handler);
  }
}

mixin _CoreInterceptorImpl on Interceptor {
  String? get _tokenProvider;

  String get _langProvider => getIt<SharedPreferences>().getAppLocal ?? 'en';

  Future<void> _onUnauthorized() {
    Loading.dismiss();
    return onUnauthorized();
  }

  Future<void> onUnauthorized();

  void _updateDialog() {
    Loading.dismiss();
    onUpdateDialog();
  }

  void onUpdateDialog();

  bool lookForTokenInResponse(RefreshTokenResponse value);

  Future<void> saveNewRefreshedToken(RefreshTokenResponse value);

  void _showMaintenanceMode() {
    Loading.dismiss();
    showMaintenanceMode();
  }

  void showMaintenanceMode();
}
