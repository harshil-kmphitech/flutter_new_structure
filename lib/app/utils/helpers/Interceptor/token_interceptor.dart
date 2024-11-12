import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:dio_smart_retry/src/retry_not_supported_exception.dart';
import 'package:flutter_new_structure/app/utils/helpers/extensions/extensions.dart';
import 'package:flutter_new_structure/app/utils/helpers/injectable/injectable.dart';
import 'package:flutter_new_structure/app/utils/helpers/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenInterceptor implements Interceptor {
  TokenInterceptor({required this.dio});

  final Dio dio;

  static const _multipartRetryHelpLink = 'https://github.com/rodion-m/dio_smart_retry#retry-requests-with-multipartform-data';

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = getIt<SharedPreferences>().getToken;
    if (token?.isNotEmpty == true) {
      'Api token $token'.log;
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['content-type'] = 'application/json';
    }

    handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.data['ResponseCode'] == 9) {
      getIt<SharedPreferences>().setToken = null;

      // TODO: add Refresh Token Api here
      var requestOptions = response.requestOptions;
      if (requestOptions.data is FormData) {
        try {
          requestOptions = _recreateOptions(response.requestOptions);
        } on RetryNotSupportedException catch (e) {
          return handler.reject(
            DioException(requestOptions: requestOptions, error: e),
          );
        }
      }
      await dio.fetch<void>(requestOptions).then(
            (value) => handler.resolve(value),
          );
    } else {
      handler.next(response);
    }
  }

  RequestOptions _recreateOptions(RequestOptions options) {
    if (options.data is! FormData) {
      throw ArgumentError(
        'requestOptions.data is not FormData',
        'requestOptions',
      );
    }
    final formData = options.data as FormData;
    final newFormData = FormData();
    newFormData.fields.addAll(formData.fields);
    for (final pair in formData.files) {
      final file = pair.value;
      if (file is MultipartFileRecreatable) {
        newFormData.files.add(MapEntry(pair.key, file.recreate()));
      } else {
        throw RetryNotSupportedException(
          'Use MultipartFileRecreatable class '
          'instead of MultipartFile to make retry available. '
          'See: $_multipartRetryHelpLink',
        );
      }
    }
    return options.copyWith(data: newFormData);
  }
}
