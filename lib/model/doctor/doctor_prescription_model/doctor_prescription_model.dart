// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_prescription_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorPrescriptionModel {
  bool? success;
  List<DoctorPrescriptionData>? data;
  String? message;

  DoctorPrescriptionModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorPrescriptionModel.fromJson(Map<String, dynamic> json) => _$DoctorPrescriptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorPrescriptionModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorPrescriptionData {
  int? id;
  String? patient_name;
  String? patient_image;
  String? created_date;

  DoctorPrescriptionData({
    this.id,
    this.patient_name,
    this.patient_image,
    this.created_date,
  });
  factory DoctorPrescriptionData.fromJson(Map<String, dynamic> json) => _$DoctorPrescriptionDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorPrescriptionDataToJson(this);
}
