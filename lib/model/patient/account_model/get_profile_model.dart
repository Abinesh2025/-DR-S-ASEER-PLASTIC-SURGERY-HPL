// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'get_profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GetProfileModel {
  bool? success;
  GetProfileData? data;
  String? message;

  GetProfileModel({
    this.success,
    this.data,
    this.message,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) => _$GetProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetProfileModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetProfileData {
  int? id;
  String? first_name;
  String? email;
  String? last_name;
  String? phone_number;
  String? region_code;
  String? image_url;
  PatientAddress? address;
  String? city;
  String? pincode;
  Map<String, dynamic>? custom_field;

  GetProfileData({
    this.id,
    this.first_name,
    this.email,
    this.last_name,
    this.phone_number,
    this.region_code,
    this.image_url,
    this.address,
    this.city,
    this.pincode,
    this.custom_field,
  });

  factory GetProfileData.fromJson(Map<String, dynamic> json) => _$GetProfileDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetProfileDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientAddress {
  int? id;
  int? owner_id;
  String? owner_type;
  String? address1;
  String? address2;
  String? city;
  String? zip;
  String? tenant_id;
  String? created_at;
  String? updated_at;

  PatientAddress({
    this.id,
    this.owner_id,
    this.owner_type,
    this.address1,
    this.address2,
    this.city,
    this.zip,
    this.tenant_id,
    this.created_at,
    this.updated_at,
  });

  factory PatientAddress.fromJson(Map<String, dynamic> json) => _$PatientAddressFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAddressToJson(this);

  @override
  String toString() {
    List<String> parts = [];
    if (address1 != null && address1!.isNotEmpty) parts.add(address1!);
    if (address2 != null && address2!.isNotEmpty) parts.add(address2!);
    return parts.join(", ");
  }
}
