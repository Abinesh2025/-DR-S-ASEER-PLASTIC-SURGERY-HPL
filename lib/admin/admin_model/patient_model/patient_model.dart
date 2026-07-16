// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'patient_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientModel {
  bool? success;
  List<PatientsData>? data;
  String? message;

  PatientModel({
    this.success,
    this.data,
    this.message,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) => _$PatientModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientsData {
  int? id;
  String? patient_name;
  String? phone_no;
  String? patient_image;

  PatientsData({
    this.id,
    this.patient_name,
    this.phone_no,
    this.patient_image,
  });
  factory PatientsData.fromJson(Map<String, dynamic> json) => _$PatientsDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientsDataToJson(this);
}
