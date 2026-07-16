// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'bed_status_details_model.g.dart';

@JsonSerializable()
class BedStatusDetailsModel {
  bool? success;
  BedStatusDetailsData? data;
  String? message;

  BedStatusDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory BedStatusDetailsModel.fromJson(Map<String, dynamic> json) => _$BedStatusDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$BedStatusDetailsModelToJson(this);
}

@JsonSerializable()
class BedStatusDetailsData {
  String? bed_name;
  String? patient;
  String? phone;
  String? admission_date;
  String? gender;

  BedStatusDetailsData({
    this.bed_name,
    this.patient,
    this.phone,
    this.admission_date,
    this.gender,
  });

  factory BedStatusDetailsData.fromJson(Map<String, dynamic> json) => _$BedStatusDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$BedStatusDetailsDataToJson(this);
}
