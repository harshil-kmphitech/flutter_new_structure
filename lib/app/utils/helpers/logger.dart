import 'dart:developer' as dev;

import 'package:dio/dio.dart';

extension LoggerExtension<T> on T {
  T get log {
    if (this case (final Object e, final StackTrace stackTrace)) {
      dev.log(e.toString(), stackTrace: stackTrace);
    } else if (this case final StackOverflowError e) {
      dev.log(e.toString(), stackTrace: e.stackTrace);
    } else if (this case final ArgumentError e) {
      dev.log(e.toString(), stackTrace: e.stackTrace);
    } else if (this case final DioException e) {
      dev.log(e.toString(), stackTrace: e.stackTrace);
    } else if (this case final TypeError e) {
      dev.log(e.toString(), stackTrace: e.stackTrace);
    } else {
      dev.log(toString());
    }
    return this;
  }

  T logWithName(String name) {
    dev.log(toString(), name: name);
    return this;
  }
}
