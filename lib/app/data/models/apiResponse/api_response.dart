import 'package:app/app/data/models/core/core.dart';
import 'package:app/app/utils/constants/app_edge_insets.dart';
import 'package:get/get.dart';

part 'api_response.g.dart';

abstract class ApiResponse {
  const ApiResponse({required this.isSuccess, required this.statusCode, required this.message});

  final int statusCode;
  final bool isSuccess;
  final String message;

  void showToast([String? message]) {
    showToastStatic(message ?? this.message);
  }

  static void showToastStatic([String? message]) {
    Get.showSnackbar(
      GetSnackBar(
        message: message,
        borderRadius: 10,
        padding: const AppEdgeInsets.all12(),
        duration: const Duration(seconds: 2),
        margin: const AppEdgeInsets.h16(),
      ),
    );
  }
}

BaseResponse deserializeBaseResponse(Map<String, dynamic> json) => BaseResponse.fromJson(json);

@AppJson()
class BaseResponse extends ApiResponse {
  BaseResponse({
    required this.data,
    required super.isSuccess,
    required super.statusCode,
    required super.message,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

  final dynamic data;

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
