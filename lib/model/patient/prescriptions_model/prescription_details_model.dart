// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'prescription_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PrescriptionDetailsModel {
  bool? success;
  PrescriptionsDetailsData? data;
  String? message;

  PrescriptionDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory PrescriptionDetailsModel.fromJson(Map<String, dynamic> json) => _$PrescriptionDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PrescriptionsDetailsData {
  String? doctor_name;
  String? specialist;
  String? problem;
  String? test;
  String? advice;
  List<Medicine>? medicine;
  String? download_prescription;
  String? app_logo;

  PrescriptionsDetailsData({
    this.doctor_name,
    this.specialist,
    this.problem,
    this.test,
    this.advice,
    this.medicine,
    this.download_prescription,
    this.app_logo
  });

  factory PrescriptionsDetailsData.fromJson(Map<String, dynamic> json) => _$PrescriptionsDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$PrescriptionsDetailsDataToJson(this);
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
