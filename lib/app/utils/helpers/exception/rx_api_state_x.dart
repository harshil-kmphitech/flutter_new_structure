part of 'exception.dart';

class RxApiState<T> extends Rx<ApiState<T>> {
  RxApiState([super.initial = const InitialState()]);

  bool get isInitial => value is InitialState<T>;
  bool get isLoading => value is LoadingState<T>;
  bool get isSuccess => value is SuccessState<T>;
  bool get isFailed => value is FailedState<T>;

  FailedState<T> get failedState => value as FailedState<T>;
  SuccessState<T> get successState => value as SuccessState<T>;
}

@immutable
sealed class ApiState<T> {
  const ApiState();
}

class SuccessState<T> extends ApiState<T> {
  const SuccessState(this.value);
  final T? value;
}

class InitialState<T> extends ApiState<T> {
  const InitialState();
}

class LoadingState<T> extends ApiState<T> {
  const LoadingState();
}

class FailedState<T> extends ApiState<T> {
  const FailedState({
    required this.isRetirable,
    required this.statusCode,
    required this.dioError,
    this.customMessage,
  });

  final String? customMessage;

  final bool isRetirable;

  UserFriendlyError get error =>
      dioError?.toUserFriendlyError() ??
      UserFriendlyError(AppStrings.T.apiError, AppStrings.T.apiErrorDescription);

  Response<dynamic>? get response => dioError?.response;

  final DioException? dioError;

  final int statusCode;

  String get message =>
      customMessage ?? (dioError?.response?.data['message'] as String?) ?? error.description;

  void showToast() {
    if (dioError?.type == DioExceptionType.cancel) {
      return;
    }
    failedToast(title: error.title, message: message);
  }

  static void failedToast({String? title, required String message}) {
    Get.showSnackbar(AppSnackBar.error(title: title, message: message));
  }
}
