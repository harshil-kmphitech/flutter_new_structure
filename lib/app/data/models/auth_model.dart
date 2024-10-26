import 'package:flutter_new_structure/app/utils/constants/json_keys.dart';

class AuthModel {
  final String? id;
  final String? name;
  final String? email;
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
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      id: json[JsonKeys.id],
      name: json[JsonKeys.name],
      email: json[JsonKeys.email],
      password: json[JsonKeys.password],
      phoneNumber: json[JsonKeys.phoneNumber],
      profileImage: json[JsonKeys.profileImage],
    );
  }

  // Method to convert an AuthModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      JsonKeys.id: id,
      JsonKeys.name: name,
      JsonKeys.email: email,
      JsonKeys.password: password,
      JsonKeys.phoneNumber: phoneNumber,
      JsonKeys.profileImage: profileImage,
    };
  }
}
