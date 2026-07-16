// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'doctor_live_consultations_meeting_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DoctorLiveConsultationsMeetingModel {
  bool? success;
  DoctorLiveConsultationsMeetingData? data;
  String? message;

  DoctorLiveConsultationsMeetingModel({
    this.success,
    this.data,
    this.message,
  });

  factory DoctorLiveConsultationsMeetingModel.fromJson(Map<String, dynamic> json) => _$DoctorLiveConsultationsMeetingModelFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorLiveConsultationsMeetingModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DoctorLiveConsultationsMeetingData {
  String? consultation_title;
  String? status;
  String? host_video;
  String? consultation_date;
  String? duration_minutes;
  String? meta;

  DoctorLiveConsultationsMeetingData({
    this.consultation_title,
    this.status,
    this.host_video,
    this.consultation_date,
    this.duration_minutes,
    this.meta,
  });
  factory DoctorLiveConsultationsMeetingData.fromJson(Map<String, dynamic> json) => _$DoctorLiveConsultationsMeetingDataFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorLiveConsultationsMeetingDataToJson(this);
}
