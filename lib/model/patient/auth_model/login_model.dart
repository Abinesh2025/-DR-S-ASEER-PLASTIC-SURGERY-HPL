// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'login_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginModel {
  bool? success;
  LoginData? data;
  String? message;

  LoginModel({
    this.success,
    this.data,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => _$LoginModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LoginData {
  String? token;
  String? role;
  UserData? user;

  LoginData({
    this.token,
    this.role,
    this.user,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) => _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserData {
  int? id;
  String? first_name;
  String? last_name;
  String? email;
  String? phone_number;
  String? image_url;

  UserData({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.phone_number,
    this.image_url,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
