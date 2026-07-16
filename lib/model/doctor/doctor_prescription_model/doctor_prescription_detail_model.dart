// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_prescription_detail_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorPrescriptionDetailModel {
  bool? success;
  DoctorPrescriptionDetailData? data;
  String? message;

  DoctorPrescriptionDetailModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorPrescriptionDetailModel.fromJson(Map<String, dynamic> json) => _$DoctorPrescriptionDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorPrescriptionDetailModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorPrescriptionDetailData {
  int? id;
  int? doctor_id;
  String? doctor_name;
  String? specialist;
  String? patient_name;
  int? patient_age;
  String? created_date;
  String? created_time;
  String? problem;
  String? test;
  String? advice;
  List<Medicine>? medicine;
  String? download_prescription;
  String? app_logo;

  DoctorPrescriptionDetailData({
    this.id,
    this.doctor_id,
    this.doctor_name,
    this.specialist,
    this.patient_name,
    this.patient_age,
    this.created_date,
    this.created_time,
    this.problem,
    this.test,
    this.advice,
    this.medicine,
    this.download_prescription,
    this.app_logo
  });

  factory DoctorPrescriptionDetailData.fromJson(Map<String, dynamic> json) => _$DoctorPrescriptionDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorPrescriptionDetailDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Medicine {
  String? name;
  String? dosage;
  String? days;
  String? time;

  Medicine({
    this.name,
    this.dosage,
    this.time,
    this.days,
  });
  factory Medicine.fromJson(Map<String, dynamic> json) => _$MedicineFromJson(json);

  Map<String, dynamic> toJson() => _$MedicineToJson(this);
}
