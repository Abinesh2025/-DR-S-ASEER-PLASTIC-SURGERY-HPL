// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_diagnosis_test_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorDiagnosisTestDetailsModel {
  bool? success;
  DoctorDiagnosisTestDetailsData? data;
  String? message;

  DoctorDiagnosisTestDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorDiagnosisTestDetailsModel.fromJson(Map<String, dynamic> json) => _$DoctorDiagnosisTestDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDiagnosisTestDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorDiagnosisTestDetailsData {
  int? id;
  String? patient_name;
  String? patient_image;
  String? category;
  String? report_number;
  PatientDiagnosis? patient_diagnosis;
  String? created_on;
  String? pdf_url;

  DoctorDiagnosisTestDetailsData({
    this.id,
    this.patient_name,
    this.patient_image,
    this.category,
    this.report_number,
    this.patient_diagnosis,
    this.created_on,
    this.pdf_url,
  });
  factory DoctorDiagnosisTestDetailsData.fromJson(Map<String, dynamic> json) => _$DoctorDiagnosisTestDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorDiagnosisTestDetailsDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientDiagnosis {
  String? age;
  String? height;
  String? weight;
  String? average_glucose;
  String? fasting_blood_sugar;
  String? urine_sugar;
  String? blood_pressure;
  String? diabetes;
  String? cholesterol;
  String? sd;
  String? cxcx;

  PatientDiagnosis({
    this.age,
    this.height,
    this.weight,
    this.average_glucose,
    this.fasting_blood_sugar,
    this.urine_sugar,
    this.blood_pressure,
    this.diabetes,
    this.cholesterol,
    this.sd,
    this.cxcx,
  });
  factory PatientDiagnosis.fromJson(Map<String, dynamic> json) => _$PatientDiagnosisFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDiagnosisToJson(this);
}
