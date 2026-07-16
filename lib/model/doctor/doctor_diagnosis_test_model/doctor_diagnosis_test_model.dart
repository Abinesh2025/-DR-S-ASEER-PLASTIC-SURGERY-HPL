// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_diagnosis_test_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorDiagnosisTestModel {
  bool? success;
  List<DoctorDiagnosisTestData>? data;
  String? message;

  DoctorDiagnosisTestModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorDiagnosisTestModel.fromJson(Map<String, dynamic> json) => _$DoctorDiagnosisTestModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDiagnosisTestModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorDiagnosisTestData {
  int? id;
  String? patient_name;
  String? patient_image;
  String? category;
  String? report_number;
  String? created_at;
  String? pdf_url;

  DoctorDiagnosisTestData({
    this.id,
    this.patient_name,
    this.patient_image,
    this.category,
    this.report_number,
    this.created_at,
    this.pdf_url,
  });
  factory DoctorDiagnosisTestData.fromJson(Map<String, dynamic> json) => _$DoctorDiagnosisTestDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDiagnosisTestDataToJson(this);
}
