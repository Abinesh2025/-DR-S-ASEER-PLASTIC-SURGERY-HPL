// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'filter_hospital_model.g.dart';

@JsonSerializable()
class FilterHospitalModel {
  bool? success;
  List<FilterHospitalData>? data;
  String? message;

  FilterHospitalModel({
    this.success,
    this.data,
    this.message
  });

  factory FilterHospitalModel.fromJson(Map<String, dynamic> json) => _$FilterHospitalModelFromJson(json);
  Map<String, dynamic> toJson() => _$FilterHospitalModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FilterHospitalData {
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

  FilterHospitalData({
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

  factory FilterHospitalData.fromJson(Map<String, dynamic> json) => _$FilterHospitalDataFromJson(json);

  Map<String, dynamic> toJson() => _$FilterHospitalDataToJson(this);

}
