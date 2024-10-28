import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

AuthModel deserializeAuthModel(Map<String, dynamic> json) => AuthModel.fromJson(json);

@JsonSerializable()
class AuthModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? email;
  @JsonKey(fromJson: _convertToEncrypted)
  final String? password;
  final String? phoneNumber;
  final String? profileImage;

  AuthModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.profileImage,
  });

  // Factory method to create an AuthModel from JSON
  factory AuthModel.fromJson(Map<String, dynamic> json) => _$AuthModelFromJson(json);

  // Method to convert an AuthModel instance to JSON
  Map<String, dynamic> toJson() => _$AuthModelToJson(this);

  static String _convertToEncrypted(String value) {
    // Write logic here to customize Json response here.
    return value;
  }
}
