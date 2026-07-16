// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'patient_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientsDetailModel {
  bool? success;
  PatientsDetailData? data;
  String? message;

  PatientsDetailModel({
    this.success,
    this.data,
    this.message,
  });

  factory PatientsDetailModel.fromJson(Map<String, dynamic> json) => _$PatientsDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientsDetailModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientsDetailData {
  int? id;
  String? patient_name;
  String? email_id;
  String? phone_no;
  String? blood_group;

  PatientsDetailData({
    this.id,
    this.patient_name,
    this.email_id,
    this.phone_no,
    this.blood_group,
  });
  factory PatientsDetailData.fromJson(Map<String, dynamic> json) => _$PatientsDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientsDetailDataToJson(this);
}
