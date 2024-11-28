import 'package:demo/app/data/models/authModel/auth_model.dart';
import 'package:demo/app/global/app_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart' as i;
import 'package:retrofit/retrofit.dart';

part 'auth_service.g.dart';

// ignore: public_member_api_docs
Map<String, dynamic> deserializedynamic(Map<String, dynamic> json) => json;

/// Add base Url here..
@RestApi(parser: Parser.FlutterCompute, baseUrl: AppConfig.baseUrl)
@i.lazySingleton
@i.injectable
abstract class AuthService {
  @i.factoryMethod
  factory AuthService(Dio dio) = _AuthService;

  @POST(EndPoints.userLogin)
  Future<AuthModel?> login(
    @Part() String email,
    @Part() String pass, {
    @Part() String role = 'Student',
  });

  @POST(EndPoints.userSignUp)
  Future<AuthModel?> register({
    @Part() required String email,
    @Part() required String pass,
    @Part() required String otp,
    @Part() required String role,
    @Part() required String phone,
    @Part() required String ccode,
    @Part() required String name,
  });

  @POST(EndPoints.userForgotPassword)
  Future<HttpResponse<Map<String, dynamic>>> forgotPassword(@Part() String email);

  @POST(EndPoints.userUpdatePassword)
  Future<AuthModel> resetPassword(
    @Part() String email,
    @Part(name: 'new_password') String newPassword,
  );

  @POST(EndPoints.userVerifyOTP)
  Future<HttpResponse<Map<String, dynamic>>> verifyCode(
    @Part() String email,
    @Part() String otp,
  );

  @POST(EndPoints.userSendOTP)
  Future<HttpResponse<Map<String, dynamic>>> sendOTP(
    @Part() String email,
    @Part() String name,
  );

  /// There many more methods available for Server communication like PUT, DELETE, PATCH, HEAD etc...
  /// For upload Files with PART.
}
