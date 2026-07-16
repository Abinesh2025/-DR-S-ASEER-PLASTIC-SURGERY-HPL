// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'diagnosis_test_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DiagnosisTestModel {
  bool? success;
  List<DiagnosisTestData>? data;
  String? message;

  DiagnosisTestModel({
    this.success,
    this.data,
    this.message,
  });

  factory DiagnosisTestModel.fromJson(Map<String, dynamic> json) => _$DiagnosisTestModelFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisTestModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DiagnosisTestData {
  int? id;
  String? patient_name;
  String? patient_image;
  String? category;
  String? report_number;
  String? created_at;
  String? pdf_url;

  DiagnosisTestData({
    this.id,
    this.patient_name,
    this.patient_image,
    this.category,
    this.report_number,
    this.created_at,
    this.pdf_url,
  });
  factory DiagnosisTestData.fromJson(Map<String, dynamic> json) => _$DiagnosisTestDataFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisTestDataToJson(this);
}
