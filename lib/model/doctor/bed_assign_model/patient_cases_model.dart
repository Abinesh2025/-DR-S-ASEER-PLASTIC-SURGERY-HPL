// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'patient_cases_model.g.dart';

@JsonSerializable()
class PatientCases {
  bool? success;
  List<PatientCaseData>? data;
  String? message;

  PatientCases({
    this.success,
    this.data,
    this.message,
  });


  factory PatientCases.fromJson(Map<String, dynamic> json) => _$PatientCasesFromJson(json);

  Map<String, dynamic> toJson() => _$PatientCasesToJson(this);


}

@JsonSerializable()
class PatientCaseData {
  String? patient_case;

  PatientCaseData({
    this.patient_case,
  });

  factory PatientCaseData.fromJson(Map<String, dynamic> json) => _$PatientCaseDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientCaseDataToJson(this);
}
