import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_new_structure/app/global/app_config.dart';
import 'package:injectable/injectable.dart' as i;
import 'package:retrofit/retrofit.dart';

import '../../routes/app_routes.dart';
import '../../utils/constants/json_keys.dart';
import '../models/auth_model.dart';

part 'generated/auth_service.g.dart';

Map<String, dynamic> deserializedynamic(Map<String, dynamic> value) => value;

/// Add base Url here..
@RestApi(parser: Parser.FlutterCompute, baseUrl: AppConfig.baseUrl)
@i.lazySingleton
@i.injectable
abstract class AuthService {
  @i.factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST(AppRoutes.login)
  Future<AuthModel?> login(
    @Query(JsonKeys.email) String email,
    @Query(JsonKeys.password) String password,
  );

  @POST(AppRoutes.login)
  Future<AuthModel?> register(@Body() AuthModel authModel);

  @POST(AppRoutes.forgotPassword)
  @FormUrlEncoded()
  Future<Map<String, dynamic>> forgotPassword(@Query(JsonKeys.email) String email);

  @POST(AppRoutes.resetPassword)
  Future<Map<String, dynamic>> resetPassword(
    @Query(JsonKeys.email) String email,
    @Query(JsonKeys.newPassword) String newPassword,
    @DioOptions() Options options,
  );

  @POST(AppRoutes.verifyCode)
  Future<Map<String, dynamic>> verifyCode(
    @Query(JsonKeys.email) String email,
    @Query(JsonKeys.code) String code,
  );

  /// There many more methods available for Server communication like PUT, DELETE, PATCH, HEAD etc...
  /// For upload Files with PART.
}
