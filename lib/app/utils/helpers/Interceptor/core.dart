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
        _onUnauthorized();
      case 426:
        _updateDialog();
      case 433:
        _queueRequest(err, handler);
      case 503:
        _showMaintenanceMode();
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
    refreshTokenState.value = const InitialState();

    for (final element in requestQueue) {
      element.next();
    }
    requestQueue.clear();
  }

  Future<void> _onRefreshSuccess(RefreshTokenResponse value) async {
    refreshTokenState.value = const InitialState();

    if (lookForTokenInResponse(value)) {
      await saveNewRefreshedToken(value);
      Future.wait(requestQueue.map((e) => e.resolve())).whenComplete(requestQueue.clear).ignore();
    } else {
      requestQueue
        ..forEach((element) => element.next())
        ..clear();
    }
  }
}

mixin _CoreInterceptorImpl on Interceptor {
  String? get _tokenProvider;

  String get _langProvider => getIt<SharedPreferences>().getAppLocal ?? 'en';

  void _onUnauthorized() {
    Loading.dismiss();
    onUnauthorized();
  }

  void onUnauthorized();

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
