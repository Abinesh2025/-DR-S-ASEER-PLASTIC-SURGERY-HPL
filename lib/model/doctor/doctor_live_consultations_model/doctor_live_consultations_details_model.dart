// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_live_consultations_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorLiveConsultationsDetailsModel {
  bool? success;
  DoctorLiveConsultationsDetailsData? data;
  String? message;

  DoctorLiveConsultationsDetailsModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorLiveConsultationsDetailsModel.fromJson(Map<String, dynamic> json) => _$DoctorLiveConsultationsDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorLiveConsultationsDetailsModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorLiveConsultationsDetailsData {
  int? id;
  String? consultation_title;
  String? consultation_date;
  String? duration_minutes;
  String? patient_name;
  String? type;
  String? type_number;

  DoctorLiveConsultationsDetailsData({
    this.id,
    this.consultation_title,
    this.consultation_date,
    this.duration_minutes,
    this.patient_name,
    this.type,
    this.type_number,
  });
  factory DoctorLiveConsultationsDetailsData.fromJson(Map<String, dynamic> json) => _$DoctorLiveConsultationsDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorLiveConsultationsDetailsDataToJson(this);
}
