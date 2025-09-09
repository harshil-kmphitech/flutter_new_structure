// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenResponse _$RefreshTokenResponseFromJson(
  Map<String, dynamic> json,
) => RefreshTokenResponse(
  statusCode: (json['statusCode'] as num).toInt(),
  isSuccess: json['isSuccess'] as bool,
  message: json['message'] as String,
  data: json['data'] as Map<String, dynamic>,
);

Map<String, dynamic> _$RefreshTokenResponseToJson(
  RefreshTokenResponse instance,
) => <String, dynamic>{
  'statusCode': instance.statusCode,
  'isSuccess': instance.isSuccess,
  'message': instance.message,
  'data': instance.data,
};
