// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'patient_admission_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PatientAdmissionDetailsModel {
  bool? success;
  PatientAdmissionDetailsData? data;
  String? message;

  PatientAdmissionDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory PatientAdmissionDetailsModel.fromJson(Map<String, dynamic> json) => _$PatientAdmissionDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAdmissionDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PatientAdmissionDetailsData {
  int? id;
  String? admission_id;
  String? patient;
  String? admission_date;
  String? discharge_date;
  String? bed;
  String? guardian_name;
  String? guardian_relation;
  String? guardian_contact;
  String? guardian_address;
  String? created_on;
  String? package_name;
  String? insurance_name;
  String? agent_name;
  String? policy_number;

  PatientAdmissionDetailsData({
    this.id,
    this.admission_id,
    this.patient,
    this.admission_date,
    this.discharge_date,
    this.bed,
    this.guardian_name,
    this.guardian_relation,
    this.guardian_contact,
    this.guardian_address,
    this.created_on,
    this.package_name,
    this.insurance_name,
    this.agent_name,
    this.policy_number,
  });
  factory PatientAdmissionDetailsData.fromJson(Map<String, dynamic> json) => _$PatientAdmissionDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$PatientAdmissionDetailsDataToJson(this);
}
