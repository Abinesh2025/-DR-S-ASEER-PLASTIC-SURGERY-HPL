// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'diagnosis_test_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DiagnosisTestDetailsModel {
  bool? success;
  DiagnosisTestDetailsData? data;
  String? message;

  DiagnosisTestDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory DiagnosisTestDetailsModel.fromJson(Map<String, dynamic> json) => _$DiagnosisTestDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisTestDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DiagnosisTestDetailsData {
  int? id;
  String? patient_name;
  String? patient_image;
  String? doctor_name;
  String? doctor_image;
  String? category;
  String? report_number;
  PatientDiagnosis? patient_diagnosis;
  String? created_on;
  String? pdf_url;

  DiagnosisTestDetailsData({
    this.id,
    this.patient_name,
    this.patient_image,
    this.doctor_name,
    this.doctor_image,
    this.category,
    this.report_number,
    this.patient_diagnosis,
    this.created_on,
    this.pdf_url,
  });
  factory DiagnosisTestDetailsData.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = Map<String, dynamic>.from(json);
    if (data['patient_diagnosis'] is List) {
      final list = data['patient_diagnosis'] as List;
      data['patient_diagnosis'] = list.isNotEmpty ? list.first : null;
    }
    return _$DiagnosisTestDetailsDataFromJson(data);
  }
  Map<String, dynamic> toJson() => _$DiagnosisTestDetailsDataToJson(this);
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
  String? demo_key;

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
    this.demo_key,
  });
  factory PatientDiagnosis.fromJson(Map<String, dynamic> json) => _$PatientDiagnosisFromJson(json);

  Map<String, dynamic> toJson() => _$PatientDiagnosisToJson(this);
}
