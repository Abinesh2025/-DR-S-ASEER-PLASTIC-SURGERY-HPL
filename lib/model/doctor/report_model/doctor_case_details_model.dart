// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_case_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorCaseDetailsModel {
  bool? success;
  DoctorCaseDetailsData? data;
  String? message;

  DoctorCaseDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorCaseDetailsModel.fromJson(Map<String, dynamic> json) => _$DoctorCaseDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorCaseDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorCaseDetailsData {
  int? id;
  String? case_id;
  String? case_date;
  String? patient;
  String? phone;
  int? fee;
  String? created_on;
  String? description;
  String? currency;

  DoctorCaseDetailsData({
    this.id,
    this.case_id,
    this.case_date,
    this.patient,
    this.phone,
    this.fee,
    this.created_on,
    this.description,
    this.currency,
  });
  factory DoctorCaseDetailsData.fromJson(Map<String, dynamic> json) => _$DoctorCaseDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorCaseDetailsDataToJson(this);
}
