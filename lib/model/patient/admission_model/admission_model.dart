// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'admission_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AdmissionModel {
  bool? success;
  List<AdmissionData>? data;
  String? message;

  AdmissionModel({
    this.success,
    this.data,
    this.message,
  });

  factory AdmissionModel.fromJson(Map<String, dynamic> json) => _$AdmissionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdmissionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AdmissionData {
  int? id;
  String? patient_admission_id;
  int? doctor_id;
  String? doctor_name;
  String? doctor_image;
  String? admission_date;
  String? admission_time;
  String? discharge_date;
  String? discharge_time;
  String? bed_id;
  String? guardian_name;
  String? guardian_relation;
  String? guardian_contact;
  String? guardian_address;
  String? created_on;
  InsuranceDetail? insurance_detail;

  AdmissionData({
    this.id,
    this.patient_admission_id,
    this.doctor_id,
    this.doctor_name,
    this.doctor_image,
    this.admission_date,
    this.admission_time,
    this.discharge_date,
    this.discharge_time,
    this.bed_id,
    this.guardian_name,
    this.guardian_relation,
    this.guardian_contact,
    this.guardian_address,
    this.created_on,
    this.insurance_detail,
  });
  factory AdmissionData.fromJson(Map<String, dynamic> json) => _$AdmissionDataFromJson(json);

  Map<String, dynamic> toJson() => _$AdmissionDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InsuranceDetail {
  String? package_name;
  String? insurance_name;
  String? agent_name;
  String? policy_no;

  InsuranceDetail({
    this.package_name,
    this.insurance_name,
    this.agent_name,
    this.policy_no,
  });
  factory InsuranceDetail.fromJson(Map<String, dynamic> json) => _$InsuranceDetailFromJson(json);

  Map<String, dynamic> toJson() => _$InsuranceDetailToJson(this);
}
