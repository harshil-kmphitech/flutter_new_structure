import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dio/dio.dart';

/// Interceptor that logs HTTP responses with pretty-printed JSON
/// for easy copying from DevTools and readable formatting.
class ResponseLogInterceptor extends Interceptor {
  ResponseLogInterceptor({
    this.enableLogging = true,
    this.printToConsole = true,
    this.jsonIndent = '  ',
    this.maxBodyLength = 1024 * 1024,
  });

  /// Enable/disable logging
  final bool enableLogging;

  /// Print to console in addition to developer log
  final bool printToConsole;

  /// Indent string for JSON formatting (default 2 spaces)
  final String jsonIndent;

  /// Max response body length to log (default 1MB). Longer bodies are truncated.
  final int maxBodyLength;

  JsonEncoder get _prettyEncoder => JsonEncoder.withIndent(jsonIndent);

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    if (enableLogging) {
      final logOutput = _formatResponse(response);

      // Log as single message so DevTools shows one copyable block
      dev.log(logOutput, name: 'Response', time: DateTime.now());

      if (printToConsole) {
        print('\n📥 Response (${response.statusCode} ${response.requestOptions.uri.path}):');
        print('─' * 80);
        print(logOutput);
        print('─' * 80);
        print('');
      }
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (enableLogging) {
      final logOutput = _formatError(err);

      dev.log(logOutput, name: 'Error', time: DateTime.now());

      if (printToConsole) {
        final statusCode = err.response?.statusCode ?? '—';
        final path = err.requestOptions.uri.path;
        print('\n❌ Error ($statusCode $path) [${err.type}]:');
        print('─' * 80);
        print(logOutput);
        print('─' * 80);
        print('');
      }
    }

    super.onError(err, handler);
  }

  String _formatError(DioException err) {
    final buffer = StringBuffer();
    buffer.writeln();
    final url = err.requestOptions.uri.toString();
    buffer.write(_urlBox(url));
    buffer.writeln();
    buffer.writeln('Type: ${err.type}');
    buffer.writeln('Message: ${err.message ?? "(none)"}');
    if (err.response != null) {
      buffer.writeln('Status: ${err.response!.statusCode}');
      buffer.writeln();
      final data = err.response!.data;
      if (data != null) {
        buffer.write(_formatBody(data));
      } else {
        buffer.writeln('(empty body)');
      }
    }
    return buffer.toString();
  }

  String _formatResponse(Response<dynamic> response) {
    final buffer = StringBuffer();
    buffer.writeln();
    final url = response.requestOptions.uri.toString();
    buffer.write(_urlBox(url));
    buffer.writeln();
    buffer.writeln();

    final data = response.data;
    if (data != null) {
      buffer.write(_formatBody(data));
    } else {
      buffer.writeln('(empty)');
    }

    return buffer.toString();
  }

  String _urlBox(String url) {
    const padding = 2;
    final width = url.length + padding * 2;
    final top = '┌${'─' * width}┐';
    final middle = '│${' ' * padding}$url${' ' * padding}│';
    final bottom = '└${'─' * width}┘';
    return '$top\n$middle\n$bottom';
  }

  String _formatBody(dynamic data) {
    String raw;
    if (data is String) {
      raw = data;
    } else if (data is Map || data is List) {
      raw = _prettyEncoder.convert(data);
    } else {
      raw = data.toString();
    }

    // If it looks like JSON string, try to parse and re-format
    if (data is String && raw.trim().isNotEmpty) {
      final trimmed = raw.trim();
      if ((trimmed.startsWith('{') && trimmed.endsWith('}')) ||
          (trimmed.startsWith('[') && trimmed.endsWith(']'))) {
        try {
          final decoded = jsonDecode(raw);
          raw = _prettyEncoder.convert(decoded);
        } catch (_) {
          // Keep as-is if not valid JSON
        }
      }
    }

    if (raw.length > maxBodyLength) {
      return '${raw.substring(0, maxBodyLength)}\n\n... (truncated, total ${raw.length} chars)';
    }
    return raw;
  }
}
