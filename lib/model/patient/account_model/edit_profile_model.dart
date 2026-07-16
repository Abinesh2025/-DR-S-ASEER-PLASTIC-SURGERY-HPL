// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';
import 'get_profile_model.dart';

part 'edit_profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class EditProfileModel {
  bool? success;
  EditProfileData? data;
  String? message;

  EditProfileModel({
    this.success,
    this.data,
    this.message,
  });

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => _$EditProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EditProfileData {
  String? first_name;
  String? last_name;
  String? email;
  String? phone;
  String? region_code;
  String? profile_image;
  PatientAddress? address;
  String? city;
  String? pincode;

  EditProfileData({
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.region_code,
    this.profile_image,
    this.address,
    this.city,
    this.pincode,
  });

  factory EditProfileData.fromJson(Map<String, dynamic> json) => _$EditProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileDataToJson(this);
}
