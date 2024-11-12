// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

AuthModel deserializeAuthModel(Map<String, dynamic> json) => AuthModel.fromJson(json);

Map<String, dynamic> serializeAuthModel(AuthModel model) => model.toJson();

@JsonSerializable()
class AuthModel {
  int ResponseCode;
  String ResponseMsg;
  bool Result;
  AuthData data;

  AuthModel({
    required this.ResponseCode,
    required this.ResponseMsg,
    required this.Result,
    required this.data,
  });

  // Factory method to create an AuthModel from JSON
  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  // Method to convert an AuthModel instance to JSON
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}

@JsonSerializable()
class AuthData {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? email;
  @JsonKey(fromJson: _convertToEncrypted)
  final String? password;
  final int? phone;
  final String? profile;
  final String? token;

  AuthData({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.profile,
    this.token,
  });

  // Factory method to create an AuthModel from JSON
  factory AuthData.fromJson(Map<String, dynamic> json) => _$AuthDataFromJson(json);

  // Method to convert an AuthModel instance to JSON
  Map<String, dynamic> toJson() => _$AuthDataToJson(this);

  static String? _convertToEncrypted(String? value) {
    // Write logic here to customize Json response here.
    return value;
  }
}
