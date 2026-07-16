// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'patient_admission_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientAdmissionModel {
  bool? success;
  List<PatientAdmissionData>? data;
  String? message;

  PatientAdmissionModel({
    this.success,
    this.data,
    this.message,
  });

  factory PatientAdmissionModel.fromJson(Map<String, dynamic> json) => _$PatientAdmissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAdmissionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientAdmissionData {
  int? id;
  String? patient_name;
  String? admission_id;
  String? patient_image;
  String? admission_date;
  String? admission_time;

  PatientAdmissionData({
    this.id,
    this.patient_name,
    this.admission_id,
    this.patient_image,
    this.admission_date,
    this.admission_time,
  });

  factory PatientAdmissionData.fromJson(Map<String, dynamic> json) => _$PatientAdmissionDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAdmissionDataToJson(this);
}
