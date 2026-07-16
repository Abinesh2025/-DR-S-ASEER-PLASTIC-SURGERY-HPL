// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_live_consultations_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorLiveConsultationsModel {
  bool? success;
  List<DoctorLiveConsultationsData>? data;
  String? message;

  DoctorLiveConsultationsModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorLiveConsultationsModel.fromJson(Map<String, dynamic> json) => _$DoctorLiveConsultationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorLiveConsultationsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorLiveConsultationsData {
  int? id;
  String? consultation_title;
  String? status;
  String? consultation_time;
  String? consultation_date;
  String? patient_image;

  DoctorLiveConsultationsData({
    this.id,
    this.consultation_title,
    this.status,
    this.consultation_time,
    this.consultation_date,
    this.patient_image,
  });

  factory DoctorLiveConsultationsData.fromJson(Map<String, dynamic> json) => _$DoctorLiveConsultationsDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorLiveConsultationsDataToJson(this);
}
