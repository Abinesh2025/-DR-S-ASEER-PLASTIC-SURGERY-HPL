// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'case_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CaseModel {
  bool? success;
  List<CaseData>? data;
  String? message;

  CaseModel({
    this.success,
    this.data,
    this.message,
  });

  factory CaseModel.fromJson(Map<String, dynamic> json) => _$CaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CaseModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CaseData {
  int? id;
  String? doctor_name;
  String? doctor_image;
  String? case_id;
  String? status;
  String? case_date;
  String? case_time;
  int? fee;
  String? created_on;
  String? description;
  String? currency;
  String? app_logo;

  CaseData({
    this.id,
    this.doctor_name,
    this.doctor_image,
    this.case_id,
    this.status,
    this.case_date,
    this.case_time,
    this.fee,
    this.created_on,
    this.description,
    this.currency,
    this.app_logo
  });
  factory CaseData.fromJson(Map<String, dynamic> json) => _$CaseDataFromJson(json);

  Map<String, dynamic> toJson() => _$CaseDataToJson(this);
}
