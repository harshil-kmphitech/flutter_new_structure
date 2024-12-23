import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_new_structure/app/data/models/authModel/auth_model.dart';
import 'package:flutter_new_structure/app/global/app_config.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

// ignore: public_member_api_docs
Map<String, dynamic> deserializedynamic(Map<String, dynamic> json) => json;

/// Add base Url here..
@RestApi(parser: Parser.FlutterCompute, baseUrl: AppConfig.baseUrl)
@lazySingleton
abstract class AuthService {
  @factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST(EndPoints.userLogin)
  Future<AuthModel> login(
    @Field() String email,
    @Field() String pass, {
    @Field('device_type') required String deviceType,
    @Field('device_token') required String deviceToken,
  });

  @POST(EndPoints.userSignUp)
  Future<AuthModel> register({
    @Part() required String email,
    @Part() required String pass,
    @Part() required String otp,
    @Part() required String role,
    @Part() required String phone,
    @Part() required String ccode,
    @Part() required String name,
  });

  @POST(EndPoints.userForgotPassword)
  Future<HttpResponse<dynamic>> forgotPassword(@Field() String email);

  @POST(EndPoints.userUpdatePassword)
  Future<AuthModel> resetPassword(
    @Part() String email,
    @Part(name: 'new_password') String newPassword,
  );

  @POST(EndPoints.userVerifyOTP)
  Future<HttpResponse<dynamic>> verifyCode(
    @Part() String email,
    @Part() String otp,
  );

  @POST(EndPoints.userSendOTP)
  Future<HttpResponse<dynamic>> sendOTP(
    @Part() String email,
    @Part() String name,
  );

  // Raw data passing
  @POST(EndPoints.userSendOTP)
  Future<HttpResponse<dynamic>> rawDataPassing(
    @Body() Map<String, dynamic> data,
  );

  // Request Model Passing
  @POST(EndPoints.userSendOTP)
  Future<HttpResponse<dynamic>> requestModelPassing(
    @Body() AuthModel data,
  );

  /// There many more methods available for Server communication like PUT, DELETE, PATCH, HEAD etc...
  /// For upload Files with PART.
}
