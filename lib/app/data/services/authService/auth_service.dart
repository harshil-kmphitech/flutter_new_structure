import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_new_structure/app/data/models/apiResponse/api_response.dart';
import 'package:flutter_new_structure/app/global/app_config.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'auth_service.g.dart';

@lazySingleton
@RestApi(baseUrl: AppConfig.baseUrl, parser: Parser.FlutterCompute)
abstract class AuthService {
  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST('/auth/isRegister')
  Future<BaseResponse> isRegister({
    @Field() required String email,
    @Field() required String name,
    // @Field('device_token') required String deviceToken,
    // @Field('device_type') required String deviceType,
    // @Field('is_google') num isGoogle = 0,
    @Field('is_social_type') required String isSocialType,
    // @Field('google_id') required String googleId,
  });
}
