// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'hospital_model.g.dart';

@JsonSerializable()
class HospitalModel {
  bool? success;
  List<HospitalData>? data;
  String? message;

  HospitalModel({
    this.success,
    this.data,
    this.message
  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) => _$HospitalModelFromJson(json);
  Map<String, dynamic> toJson() => _$HospitalModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class HospitalData {
  int? id;
  String? hospital_name;
  String? email;
  String? hospital_slug;
  String? hospital_type;
  dynamic hospital_type_id;
  String? city;
  int? status;
  String? phone_no;
  String? region_code;
  String? image_url;

  HospitalData({
    this.id,
    this.hospital_name,
    this.email,
    this.hospital_slug,
    this.hospital_type,
    this.hospital_type_id,
    this.city,
    this.status,
    this.phone_no,
    this.region_code,
    this.image_url
  });

  factory HospitalData.fromJson(Map<String, dynamic> json) => _$HospitalDataFromJson(json);

  Map<String, dynamic> toJson() => _$HospitalDataToJson(this);

}
