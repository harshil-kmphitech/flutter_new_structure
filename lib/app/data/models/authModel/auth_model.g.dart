// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      ResponseCode: (json['ResponseCode'] as num).toInt(),
      ResponseMsg: json['ResponseMsg'] as String,
      Result: json['Result'] as bool,
      data: AuthData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'ResponseCode': instance.ResponseCode,
      'ResponseMsg': instance.ResponseMsg,
      'Result': instance.Result,
      'data': instance.data,
    };

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: AuthData._convertToEncrypted(json['password'] as String?),
      phone: (json['phone'] as num?)?.toInt(),
      profile: json['profile'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'profile': instance.profile,
      'token': instance.token,
    };
