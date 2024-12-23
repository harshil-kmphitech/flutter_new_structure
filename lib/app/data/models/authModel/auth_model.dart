// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:flutter_new_structure/app/data/models/common/common.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

AuthModel deserializeAuthModel(Map<String, dynamic> json) => AuthModel.fromJson(json);

Map<String, dynamic> serializeAuthModel(AuthModel model) => model.toJson();

@JsonSerializable()
class AuthModel extends ApiResponse {
  AuthData data;

  AuthModel({
    required this.data,
    required super.version,
    required super.statusCode,
    required super.isSuccess,
    required super.message,
  });

  // Factory method to create an AuthModel from JSON
  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  // Method to convert an AuthModel instance to JSON
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}

@JsonSerializable()
class AuthData {
  @JsonKey(name: '_id')
  String id;
  String name;
  String email;
  String password;
  @JsonKey(name: 'is_confirm')
  String isConfirm;
  String profile;
  String ucode;
  @JsonKey(name: 'device_type')
  String deviceType;
  String token;
  @JsonKey(name: 'device_token')
  String deviceToken;
  @JsonKey(name: 'is_fb')
  String isFb;
  @JsonKey(name: 'fb_id')
  String fbId;
  @JsonKey(name: 'is_google')
  String isGoogle;
  @JsonKey(name: 'google_id')
  String googleId;
  @JsonKey(name: 'is_apple')
  String isApple;
  @JsonKey(name: 'apple_id')
  String appleId;
  @JsonKey(name: 'delete_reason')
  String deleteReason;
  @JsonKey(name: 'is_subscription')
  String isSubscription;
  @JsonKey(name: 'plan_expiry')
  String planExpiry;
  @JsonKey(name: 'last_purchase_token')
  String lastPurchaseToken;
  @JsonKey(name: 'original_transaction_id')
  String originalTransactionId;
  @JsonKey(name: 'apple_transaction_id')
  String appleTransactionId;
  @JsonKey(name: 'product_id')
  String productId;
  @JsonKey(name: 'is_free_trial_used')
  int isFreeTrialUsed;

  AuthData({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.isConfirm,
    required this.profile,
    required this.ucode,
    required this.deviceType,
    required this.token,
    required this.deviceToken,
    required this.isFb,
    required this.fbId,
    required this.isGoogle,
    required this.googleId,
    required this.isApple,
    required this.appleId,
    required this.deleteReason,
    required this.isSubscription,
    required this.planExpiry,
    required this.lastPurchaseToken,
    required this.originalTransactionId,
    required this.appleTransactionId,
    required this.productId,
    required this.isFreeTrialUsed,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDataToJson(this);
}

RefreshTokenResponse deserializeRefreshTokenResponse(Map<String, dynamic> json) => RefreshTokenResponse.fromJson(json);

Map<String, dynamic> serializeRefreshTokenResponse(AuthModel model) => model.toJson();

@JsonSerializable()
class RefreshTokenResponse extends ApiResponse {
  const RefreshTokenResponse({
    required super.version,
    required super.statusCode,
    required super.isSuccess,
    required super.message,
    required this.data,
  });

  final Map<String, dynamic> data;

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) => _$RefreshTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenResponseToJson(this);
}
