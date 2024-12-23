// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
      data: AuthData.fromJson(json['data'] as Map<String, dynamic>),
      version: json['version'] as String,
      statusCode: json['statusCode'] as num,
      isSuccess: json['isSuccess'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'version': instance.version,
      'statusCode': instance.statusCode,
      'isSuccess': instance.isSuccess,
      'message': instance.message,
      'data': instance.data,
    };

AuthData _$AuthDataFromJson(Map<String, dynamic> json) => AuthData(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      isConfirm: json['is_confirm'] as String,
      profile: json['profile'] as String,
      ucode: json['ucode'] as String,
      deviceType: json['device_type'] as String,
      token: json['token'] as String,
      deviceToken: json['device_token'] as String,
      isFb: json['is_fb'] as String,
      fbId: json['fb_id'] as String,
      isGoogle: json['is_google'] as String,
      googleId: json['google_id'] as String,
      isApple: json['is_apple'] as String,
      appleId: json['apple_id'] as String,
      deleteReason: json['delete_reason'] as String,
      isSubscription: json['is_subscription'] as String,
      planExpiry: json['plan_expiry'] as String,
      lastPurchaseToken: json['last_purchase_token'] as String,
      originalTransactionId: json['original_transaction_id'] as String,
      appleTransactionId: json['apple_transaction_id'] as String,
      productId: json['product_id'] as String,
      isFreeTrialUsed: (json['is_free_trial_used'] as num).toInt(),
    );

Map<String, dynamic> _$AuthDataToJson(AuthData instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'is_confirm': instance.isConfirm,
      'profile': instance.profile,
      'ucode': instance.ucode,
      'device_type': instance.deviceType,
      'token': instance.token,
      'device_token': instance.deviceToken,
      'is_fb': instance.isFb,
      'fb_id': instance.fbId,
      'is_google': instance.isGoogle,
      'google_id': instance.googleId,
      'is_apple': instance.isApple,
      'apple_id': instance.appleId,
      'delete_reason': instance.deleteReason,
      'is_subscription': instance.isSubscription,
      'plan_expiry': instance.planExpiry,
      'last_purchase_token': instance.lastPurchaseToken,
      'original_transaction_id': instance.originalTransactionId,
      'apple_transaction_id': instance.appleTransactionId,
      'product_id': instance.productId,
      'is_free_trial_used': instance.isFreeTrialUsed,
    };

RefreshTokenResponse _$RefreshTokenResponseFromJson(
        Map<String, dynamic> json) =>
    RefreshTokenResponse(
      version: json['version'] as String,
      statusCode: json['statusCode'] as num,
      isSuccess: json['isSuccess'] as bool,
      message: json['message'] as String,
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$RefreshTokenResponseToJson(
        RefreshTokenResponse instance) =>
    <String, dynamic>{
      'version': instance.version,
      'statusCode': instance.statusCode,
      'isSuccess': instance.isSuccess,
      'message': instance.message,
      'data': instance.data,
    };
